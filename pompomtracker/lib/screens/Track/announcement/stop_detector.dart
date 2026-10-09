import 'dart:math';
import 'package:pompomtracker/model/track/stoploc_resp/stop.dart';

enum StopEventType { warning, next, arrived }

enum StopState { upcoming, warningPlayed, nextPlayed, arrived }

class StopEvent {
  final StopEventType type;
  final Stop stop;
  final double distance;

  const StopEvent({
    required this.type,
    required this.stop,
    required this.distance,
  });
}

class RouteSegment {
  final int startIndex;
  final int endIndex;
  final double offset;

  const RouteSegment({
    required this.startIndex,
    required this.endIndex,
    required this.offset,
  });
}

class StopDetector {
  StopDetector._();
  static final StopDetector instance = StopDetector._();

  // Thresholds (in meters)
  static const double warningDistance = 300.0;
  static const double nextDistance = 100.0;
  static const double arrivalDistance =
      35.0; // Increased slightly for GPS margin
  static const double passedDistance = 60.0;

  // Missed stop threshold: if bus comes close and moves away past this distance
  static const double missedStopDistance = 150.0;

  // Jump filter configuration
  static const double minJumpThreshold = 400.0;
  static const int maxAllowedConsecutiveJumps = 3;

  List<Stop> _stops = [];
  int _passedIndex = -1;
  int _targetIndex = 0;
  bool _initialized = false;
  StopState _state = StopState.upcoming;

  double? _lastLat;
  double? _lastLng;
  DateTime? _lastTimestamp;
  int _consecutiveJumpCount = 0;

  // Track minimum distance recorded for current target to detect when bus moves away
  double _minDistanceToTarget = double.infinity;

  Stop? get currentStop => (_targetIndex >= 0 && _targetIndex < _stops.length)
      ? _stops[_targetIndex]
      : null;

  Stop? get previousStop => (_passedIndex >= 0 && _passedIndex < _stops.length)
      ? _stops[_passedIndex]
      : null;

  bool get tripFinished => _targetIndex >= _stops.length;
  int get currentIndex => _targetIndex;
  StopState get state => _state;

  void setStops(List<Stop> stops) {
    _stops = stops;
    reset();
  }

  void reset() {
    _passedIndex = -1;
    _targetIndex = 0;
    _initialized = false;
    _state = StopState.upcoming;
    _lastLat = null;
    _lastLng = null;
    _lastTimestamp = null;
    _consecutiveJumpCount = 0;
    _minDistanceToTarget = double.infinity;
  }

  void initialize({required double busLat, required double busLng}) {
    if (_initialized || _stops.length < 2) return;

    final segment = findNearestSegment(busLat: busLat, busLng: busLng);
    _passedIndex = segment.startIndex;
    _targetIndex = segment.endIndex;
    _state = StopState.upcoming;
    _minDistanceToTarget = double.infinity;
    _initialized = true;

    print(
        "📍 STOP DETECTOR INITIALIZED -> Target: ${currentStop?.stopName} [Index: $_targetIndex]");
  }

  StopEvent? check({
    required double busLat,
    required double busLng,
    double speedKmH = 0.0,
  }) {
    if (_stops.isEmpty) return null;

    if (!_initialized) {
      initialize(busLat: busLat, busLng: busLng);
    }

    if (tripFinished) {
      return null;
    }

    final now = DateTime.now();

    // -----------------------------------------------------------
    // 1. DYNAMIC GPS JUMP FILTER
    // -----------------------------------------------------------
    if (_lastLat != null && _lastLng != null && _lastTimestamp != null) {
      final double jumpDistance =
          calculateDistance(_lastLat!, _lastLng!, busLat, busLng);
      final double elapsedSeconds =
          max(1.0, now.difference(_lastTimestamp!).inMilliseconds / 1000.0);

      final double maxSpeedMS = speedKmH > 0 ? (speedKmH / 3.6) : 35.0;
      final double dynamicThreshold =
          max(minJumpThreshold, (maxSpeedMS * elapsedSeconds) + 250.0);

      if (jumpDistance > dynamicThreshold) {
        _consecutiveJumpCount++;

        if (_consecutiveJumpCount < maxAllowedConsecutiveJumps) {
          print(
              "⚠️ GPS Jump Ignored (${_consecutiveJumpCount}/$maxAllowedConsecutiveJumps): ${jumpDistance.toStringAsFixed(1)}m");
          return null;
        } else {
          print(
              "🔄 Jump filter auto-synced position after $maxAllowedConsecutiveJumps failures.");
          _consecutiveJumpCount = 0;
        }
      } else {
        _consecutiveJumpCount = 0;
      }
    }

    _lastLat = busLat;
    _lastLng = busLng;
    _lastTimestamp = now;

    final stop = currentStop;
    if (stop == null) return null;

    final stopLat = double.tryParse(stop.latitude ?? '') ?? 0.0;
    final stopLng = double.tryParse(stop.longitude ?? '') ?? 0.0;

    final distance = calculateDistance(busLat, busLng, stopLat, stopLng);

    // Track minimum distance achieved for current target
    if (distance < _minDistanceToTarget) {
      _minDistanceToTarget = distance;
    }

    StopEvent? generatedEvent;

    // -----------------------------------------------------------
    // 2. STATE MACHINE LOGIC
    // -----------------------------------------------------------
    if (_state == StopState.upcoming &&
        distance <= warningDistance &&
        distance > nextDistance) {
      _state = StopState.warningPlayed;
      generatedEvent = StopEvent(
          type: StopEventType.warning, stop: stop, distance: distance);
      print(
          "📢 EVENT TRIGGERED: [WARNING] -> ${stop.stopName} (${distance.toStringAsFixed(1)}m)");
    } else if ((_state == StopState.upcoming ||
            _state == StopState.warningPlayed) &&
        distance <= nextDistance &&
        distance > arrivalDistance) {
      _state = StopState.nextPlayed;
      generatedEvent =
          StopEvent(type: StopEventType.next, stop: stop, distance: distance);
      print(
          "📢 EVENT TRIGGERED: [NEXT STOP] -> ${stop.stopName} (${distance.toStringAsFixed(1)}m)");
    } else if (_state != StopState.arrived && distance <= arrivalDistance) {
      _state = StopState.arrived;
      generatedEvent = StopEvent(
          type: StopEventType.arrived, stop: stop, distance: distance);
      print(
          "📢 EVENT TRIGGERED: [ARRIVED] -> ${stop.stopName} (${distance.toStringAsFixed(1)}m)");
    }

    // -----------------------------------------------------------
    // 3. DEPARTURE & MISSED STOP RECOVERY LOGIC
    // -----------------------------------------------------------

    // Normal Departure after Arrived state
    bool isDepartedNormal =
        (_state == StopState.arrived && distance >= passedDistance);

    // Missed Stop Recovery: If warning/next was played, bus got close, but is now driving away (>150m)
    bool isMissedAndMovingAway =
        (_state == StopState.nextPlayed || _state == StopState.warningPlayed) &&
            _minDistanceToTarget <= warningDistance &&
            distance >= missedStopDistance &&
            distance > (_minDistanceToTarget + 50.0);

    // Route Segment Check: Bus has progressed significantly closer to a future segment
    bool isAheadOnRoute = false;
    if (_targetIndex < _stops.length - 1) {
      final nextStop = _stops[_targetIndex + 1];
      final nLat = double.tryParse(nextStop.latitude ?? '') ?? 0.0;
      final nLng = double.tryParse(nextStop.longitude ?? '') ?? 0.0;
      final distToNextTarget = calculateDistance(busLat, busLng, nLat, nLng);

      // If bus is closer to the SUBSEQUENT stop than to the current target stop
      if (distToNextTarget < distance && distance > 200.0) {
        isAheadOnRoute = true;
      }
    }

    if (isDepartedNormal || isMissedAndMovingAway || isAheadOnRoute) {
      final reason = isDepartedNormal
          ? "Normal Departure"
          : (isMissedAndMovingAway
              ? "Missed/Deviated Stop Recovery"
              : "Bus Passed Target on Route");

      print(
          "➡️ ADVANCING TARGET ($reason): Passed ${stop.stopName} (Index: $_targetIndex)");

      _passedIndex = _targetIndex;
      _targetIndex++;
      _state = StopState.upcoming;
      _minDistanceToTarget = double.infinity; // Reset for next target

      if (tripFinished) {
        print("🎉 ALL STOPS COMPLETED!");
      } else {
        print("📍 NEW TARGET: ${currentStop?.stopName} (Index: $_targetIndex)");
      }
    }

    return generatedEvent;
  }

  RouteSegment findNearestSegment(
      {required double busLat, required double busLng}) {
    if (_stops.length < 2) {
      return const RouteSegment(startIndex: 0, endIndex: 0, offset: 0);
    }

    double minOffset = double.infinity;
    int bestStart = 0;
    int bestEnd = 1;

    for (int i = 0; i < _stops.length - 1; i++) {
      final s1 = _stops[i];
      final s2 = _stops[i + 1];

      final lat1 = double.tryParse(s1.latitude ?? '') ?? 0.0;
      final lng1 = double.tryParse(s1.longitude ?? '') ?? 0.0;
      final lat2 = double.tryParse(s2.latitude ?? '') ?? 0.0;
      final lng2 = double.tryParse(s2.longitude ?? '') ?? 0.0;

      final offset = distanceToSegment(busLat, busLng, lat1, lng1, lat2, lng2);

      if (offset < minOffset) {
        minOffset = offset;
        bestStart = i;
        bestEnd = i + 1;
      }
    }

    return RouteSegment(
      startIndex: bestStart,
      endIndex: bestEnd,
      offset: minOffset,
    );
  }

  double distanceToSegment(
    double pLat,
    double pLng,
    double aLat,
    double aLng,
    double bLat,
    double bLng,
  ) {
    final double l2 = calculateDistance(aLat, aLng, bLat, bLng);
    if (l2 == 0) return calculateDistance(pLat, pLng, aLat, aLng);

    final double d1 = calculateDistance(aLat, aLng, pLat, pLng);
    final double d2 = calculateDistance(bLat, bLng, pLat, pLng);

    final double t = ((d1 * d1) - (d2 * d2) + (l2 * l2)) / (2 * l2 * l2);

    if (t < 0.0) return calculateDistance(pLat, pLng, aLat, aLng);
    if (t > 1.0) return calculateDistance(pLat, pLng, bLat, bLng);

    final double projLat = aLat + t * (bLat - aLat);
    final double projLng = aLng + t * (bLng - aLng);

    return calculateDistance(pLat, pLng, projLat, projLng);
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000.0;
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _deg2rad(double degree) => degree * pi / 180.0;
}
// import 'dart:math';
// import 'package:pompomtracker/model/track/stoploc_resp/stop.dart';

// enum StopEventType { warning, next, arrived }

// enum StopState { upcoming, warningPlayed, nextPlayed, arrived }

// class StopEvent {
//   final StopEventType type;
//   final Stop stop;
//   final double distance;

//   const StopEvent({
//     required this.type,
//     required this.stop,
//     required this.distance,
//   });
// }

// class RouteSegment {
//   final int startIndex;
//   final int endIndex;
//   final double offset;

//   const RouteSegment({
//     required this.startIndex,
//     required this.endIndex,
//     required this.offset,
//   });
// }

// class StopDetector {
//   StopDetector._();
//   static final StopDetector instance = StopDetector._();

//   // Thresholds (in meters)
//   static const double warningDistance = 300.0;
//   static const double nextDistance = 100.0;
//   static const double arrivalDistance = 25.0;
//   static const double passedDistance = 50.0;

//   // Base Jump Filter Settings
//   static const double minJumpThreshold = 300.0; // Minimum allowed distance per tick
//   static const int maxAllowedConsecutiveJumps = 3; // Force acceptance after 3 rejections

//   List<Stop> _stops = [];
//   int _passedIndex = -1;
//   int _targetIndex = 0;
//   bool _initialized = false;
//   StopState _state = StopState.upcoming;

//   double? _lastLat;
//   double? _lastLng;
//   DateTime? _lastTimestamp;
//   int _consecutiveJumpCount = 0;

//   Stop? get currentStop =>
//       (_targetIndex >= 0 && _targetIndex < _stops.length) ? _stops[_targetIndex] : null;

//   Stop? get previousStop =>
//       (_passedIndex >= 0 && _passedIndex < _stops.length) ? _stops[_passedIndex] : null;

//   bool get tripFinished => _targetIndex >= _stops.length;
//   int get currentIndex => _targetIndex;
//   StopState get state => _state;

//   void setStops(List<Stop> stops) {
//     _stops = stops;
//     reset();
//   }

//   void reset() {
//     _passedIndex = -1;
//     _targetIndex = 0;
//     _initialized = false;
//     _state = StopState.upcoming;
//     _lastLat = null;
//     _lastLng = null;
//     _lastTimestamp = null;
//     _consecutiveJumpCount = 0;
//   }

//   void initialize({required double busLat, required double busLng}) {
//     if (_initialized || _stops.length < 2) return;

//     final segment = findNearestSegment(busLat: busLat, busLng: busLng);
//     _passedIndex = segment.startIndex;
//     _targetIndex = segment.endIndex;
//     _state = StopState.upcoming;
//     _initialized = true;

//     print("=========================================");
//     print("📍 STOP DETECTOR INITIALIZED");
//     print("   Previous Stop : ${previousStop?.stopName ?? 'None'} (Index: $_passedIndex)");
//     print("   Target Stop   : ${currentStop?.stopName ?? 'None'} (Index: $_targetIndex)");
//     print("   Offset        : ${segment.offset.toStringAsFixed(2)} m");
//     print("=========================================");
//   }

//   StopEvent? check({
//     required double busLat,
//     required double busLng,
//     double speedKmH = 0.0, // Optional speed in km/h
//   }) {
//     if (_stops.isEmpty) return null;

//     if (!_initialized) {
//       initialize(busLat: busLat, busLng: busLng);
//     }

//     if (tripFinished) {
//       print("🏁 Trip is already finished. Detector idle.");
//       return null;
//     }

//     final now = DateTime.now();

//     // -----------------------------------------------------------
//     // DYNAMIC GPS JUMP FILTER
//     // -----------------------------------------------------------
//     if (_lastLat != null && _lastLng != null && _lastTimestamp != null) {
//       final double jumpDistance = calculateDistance(_lastLat!, _lastLng!, busLat, busLng);
//       final double elapsedSeconds = max(1.0, now.difference(_lastTimestamp!).inMilliseconds / 1000.0);

//       // Estimate max plausible distance moved based on speed or default cap (120 km/h = ~33 m/s)
//       final double maxSpeedMS = speedKmH > 0 ? (speedKmH / 3.6) : 33.3;
//       final double dynamicThreshold = max(minJumpThreshold, (maxSpeedMS * elapsedSeconds) + 200.0);

//       if (jumpDistance > dynamicThreshold) {
//         _consecutiveJumpCount++;

//         // If we get repeated "jumps", assume the vehicle actually moved that far (e.g. app recovered)
//         if (_consecutiveJumpCount < maxAllowedConsecutiveJumps) {
//           print("⚠️ GPS Jump Ignored ($_consecutiveJumpCount/$maxAllowedConsecutiveJumps): ${jumpDistance.toStringAsFixed(1)} m exceeds dynamic threshold (${dynamicThreshold.toStringAsFixed(1)} m over ${elapsedSeconds.toStringAsFixed(1)}s)");
//           return null;
//         } else {
//           print("🔄 GPS Jump threshold exceeded $maxAllowedConsecutiveJumps times in a row. Accepting new location to prevent deadlock.");
//           _consecutiveJumpCount = 0;
//         }
//       } else {
//         _consecutiveJumpCount = 0;
//       }
//     }

//     // Update reference position
//     _lastLat = busLat;
//     _lastLng = busLng;
//     _lastTimestamp = now;

//     final stop = currentStop;
//     if (stop == null) return null;

//     final stopLat = double.tryParse(stop.latitude ?? '') ?? 0.0;
//     final stopLng = double.tryParse(stop.longitude ?? '') ?? 0.0;

//     final distance = calculateDistance(busLat, busLng, stopLat, stopLng);

//     // -----------------------------------------------------------
//     // DEBUG LOGS
//     // -----------------------------------------------------------
//     print("-----------------------------------------");
//     print("🚌 BUS POSITION CHECK");
//     print("   Passed Stop  : ${previousStop?.stopName ?? 'None'} [Index: $_passedIndex]");
//     print("   Next Target  : ${stop.stopName ?? 'Unknown'} [Index: $_targetIndex / ${_stops.length - 1}]");
//     print("   Distance     : ${distance.toStringAsFixed(1)} meters");
//     print("   Current State: $_state");
//     print("-----------------------------------------");

//     StopEvent? generatedEvent;

//     // State Machine logic
//     if (_state == StopState.upcoming && distance <= warningDistance && distance > nextDistance) {
//       _state = StopState.warningPlayed;
//       generatedEvent = StopEvent(type: StopEventType.warning, stop: stop, distance: distance);
//       print("📢 EVENT TRIGGERED: [WARNING] -> Approaching ${stop.stopName} (${distance.toStringAsFixed(1)}m)");
//     } else if ((_state == StopState.upcoming || _state == StopState.warningPlayed) &&
//         distance <= nextDistance &&
//         distance > arrivalDistance) {
//       _state = StopState.nextPlayed;
//       generatedEvent = StopEvent(type: StopEventType.next, stop: stop, distance: distance);
//       print("📢 EVENT TRIGGERED: [NEXT STOP] -> ${stop.stopName} (${distance.toStringAsFixed(1)}m)");
//     } else if (_state != StopState.arrived && distance <= arrivalDistance) {
//       _state = StopState.arrived;
//       generatedEvent = StopEvent(type: StopEventType.arrived, stop: stop, distance: distance);
//       print("📢 EVENT TRIGGERED: [ARRIVED] -> Reached ${stop.stopName} (${distance.toStringAsFixed(1)}m)");
//     }

//     // Departure logic: target stop passed, advance index
//     if (_state == StopState.arrived && distance >= passedDistance) {
//       print("🚗 DEPARTING STOP: ${stop.stopName} (Distance from stop: ${distance.toStringAsFixed(1)}m >= ${passedDistance}m)");
//       _passedIndex = _targetIndex;
//       _targetIndex++;
//       _state = StopState.upcoming;

//       if (tripFinished) {
//         print("🎉 ALL STOPS COMPLETED! TRIP FINISHED.");
//       } else {
//         print("➡️ ADVANCED TO NEXT TARGET: ${currentStop?.stopName} (Index: $_targetIndex)");
//       }
//     }

//     return generatedEvent;
//   }

//   RouteSegment findNearestSegment({required double busLat, required double busLng}) {
//     if (_stops.length < 2) {
//       return const RouteSegment(startIndex: 0, endIndex: 0, offset: 0);
//     }

//     double minOffset = double.infinity;
//     int bestStart = 0;
//     int bestEnd = 1;

//     for (int i = 0; i < _stops.length - 1; i++) {
//       final s1 = _stops[i];
//       final s2 = _stops[i + 1];

//       final lat1 = double.tryParse(s1.latitude ?? '') ?? 0.0;
//       final lng1 = double.tryParse(s1.longitude ?? '') ?? 0.0;
//       final lat2 = double.tryParse(s2.latitude ?? '') ?? 0.0;
//       final lng2 = double.tryParse(s2.longitude ?? '') ?? 0.0;

//       final offset = distanceToSegment(busLat, busLng, lat1, lng1, lat2, lng2);

//       if (offset < minOffset) {
//         minOffset = offset;
//         bestStart = i;
//         bestEnd = i + 1;
//       }
//     }

//     return RouteSegment(
//       startIndex: bestStart,
//       endIndex: bestEnd,
//       offset: minOffset,
//     );
//   }

//   double distanceToSegment(
//     double pLat, double pLng,
//     double aLat, double aLng,
//     double bLat, double bLng,
//   ) {
//     final double l2 = calculateDistance(aLat, aLng, bLat, bLng);
//     if (l2 == 0) return calculateDistance(pLat, pLng, aLat, aLng);

//     final double d1 = calculateDistance(aLat, aLng, pLat, pLng);
//     final double d2 = calculateDistance(bLat, bLng, pLat, pLng);

//     final double t = ((d1 * d1) - (d2 * d2) + (l2 * l2)) / (2 * l2 * l2);

//     if (t < 0.0) return calculateDistance(pLat, pLng, aLat, aLng);
//     if (t > 1.0) return calculateDistance(pLat, pLng, bLat, bLng);

//     final double projLat = aLat + t * (bLat - aLat);
//     final double projLng = aLng + t * (bLng - aLng);

//     return calculateDistance(pLat, pLng, projLat, projLng);
//   }

//   double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     const earthRadius = 6371000.0;
//     final dLat = _deg2rad(lat2 - lat1);
//     final dLon = _deg2rad(lon2 - lon1);

//     final a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);

//     final c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return earthRadius * c;
//   }

//   double _deg2rad(double degree) => degree * pi / 180.0;
// }
