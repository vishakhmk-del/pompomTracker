// import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/track/stoploc_resp/bus.dart';
import 'package:sizer/sizer.dart';

class _StopMarker extends fmap.Marker {
  final Stop stop;
  final BusDetList stoploc;

  _StopMarker({required this.stop, required this.stoploc})
      : super(
          point: LatLng(
              double.parse(stop.latitude!), double.parse(stop.longitude!)),
          width: 40,
          height: 40,
          child: stop.stopName == stoploc.toStation
              ? Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                )
              : Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 20,
                ),
        );
}

// class _BusMarker extends fmap.Marker {
//   final BusDetList bus;

//   _BusMarker({required this.bus})
//       : super(
//             point: LatLng(double.parse(bus.liveLatitude!),
//                 double.parse(bus.liveLongitude!)),
//             width: 40,
//             height: 40,
//             child: Image.asset(
//               'assets/tracking/Untitled_design__8_-removebg-preview.png',
//               width: 40,
//               height: 40,
//             ));
// }
// ------------------- BUS MARKER ------------------- //
class _BusMarker extends fmap.Marker {
  final BusLocation? busloc;
  final BusValue? busvalue;
  final BusDetList bus;

  _BusMarker({required this.bus, this.busvalue, this.busloc})
      : super(
          key: const ValueKey('bus_marker'),
          point: LatLng(
            double.parse(busloc?.latitude ?? ''),
            double.parse(busloc?.longitude ?? ''),
          ),
          width: 40,
          height: 40,
          child: Image.asset(
            'assets/tracking/Untitled_design__8_-removebg-preview.png',
            width: 40,
            height: 40,
          ),
        );
}

class ScreenMapTrack extends StatefulWidget {
  const ScreenMapTrack({super.key, this.task});
  final BusDetList? task;
  @override
  State<ScreenMapTrack> createState() => _ScreenMapTrackState();
}

class _ScreenMapTrackState extends State<ScreenMapTrack> {
  final fmap.MapController _mapController = fmap.MapController();
  final PopupController _popupLayerController = PopupController();
  // Set<String> _shownPopups = {};
  bool isLoading = true;
  bool _isMapReady = false;
  bool _isUserInteracting = false;
  bool _showRecenter = false;
  LatLng? _lastBusPos; // ← new
  // String? _selectedBusId;
  List<LatLng> _routePoints = [];
  LatLng? _starting;
  List<BusDetList>? realtmBuslist = [];
  List<BusDetList>? realtmBus = [];
  List<LatLng> points = [];
  List<fmap.Marker> _popupMarkers = [];
  List<Stop> stops = [];
  BusLocation? busLocation;
  Timer? _busLocationTimer;
  bool isbuslistFetch = false;
  bool isStopFetch = false;
  BusListReq? stopreq;
  BusDetList? busDetails;
  String? selectedbusId;
  List<LatLng> _travelledPoints = []; // Completed part
  List<LatLng> _remainingPoints = []; // Remaining part
  BusValue? busvalue;

  @override
  void initState() {
    super.initState();
    if (widget.task?.busId != null && widget.task!.busId!.isNotEmpty) {
      selectedbusId = widget.task!.busId;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize(context));
  }

  Future<void> _initialize(BuildContext context) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final usrid = sharedValue!.userId;
    final value = BusListReq(userId: usrid);
    if (!context.mounted) return;
    Livelocationfun.instance.startTracking(
      context: context,
      onLocationUpdate: (position) async {
        if (position.latitude != 0 && position.longitude != 0) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            _starting = LatLng(position.latitude, position.longitude);
          });

          if (!isbuslistFetch) {
            isbuslistFetch = true; // Set the flag to true after the first call
            realtmBuslist =
                await BusTrackFunctions.instance.realbusdet(value, context);

            _onBusSelected(widget.task?.busId);
            if (!isStopFetch) {
              isStopFetch = true; // Set the flag to true after the first call

              if (!context.mounted) return;

              fetchRouteForBus(widget.task?.busId ?? '', context);
            }
          }
          // if(widget.task==null)
          // {
          //   if (realtmBuslist == null || realtmBuslist!.isEmpty) return;
          // // Check if all trip_status are "0" or null
          // final allInactive = realtmBuslist!
          //     .every((bus) => bus.tripStatus == null || bus.tripStatus == "0");
          // if (allInactive) {
          //   if (!context.mounted) return;
          //   if (mounted) {
          //     messageBox(context);
          //   }
          //   // Don't show default locations or markers
          //   setState(() {
          //     _popupMarkers = [];
          //     _routePoints = [];
          //   });
          //   return;
          // }
          // // Filter out buses with valid live lat/lng and active trip
          // final validBuses = realtmBuslist!.where((bus) {
          //   final lat = double.tryParse(bus.liveLatitude ?? '');
          //   final lng = double.tryParse(bus.liveLongitude ?? '');
          //   return lat != null && lng != null && bus.tripStatus != "0";
          // }).toList();

          // if (validBuses.isEmpty) return;

          // points = validBuses
          //     .map((bus) => LatLng(double.parse(bus.liveLatitude!),
          //         double.parse(bus.liveLongitude!)))
          //     .toList();

          // //_routePoints = points;
          // realtmBus = validBuses;

          // _buildMarkers();

          // if (!mounted) return;
          // setState(() {});
          // }else{
          //   _onBusSelected(widget.task?.busId);
          //   if (!isStopFetch) {
          //   isStopFetch = true; // Set the flag to true after the first call

          // if (!context.mounted) return;

          //   fetchRouteForBus(widget.task?.busId??'', context);
          // }

          // }
        }
      },
    );
  }

  messageBox(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "No Active Trips",
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Text(
          "There is no active trip available. You can't track your bus.",
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "OK",
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildMarkers() {
    // final selectedBus = realtmBus?.first;

    _popupMarkers = [
      // Stop markers
      ...stops.map((stop) => _StopMarker(
            stop: stop,
            stoploc: busDetails!,
          )),
      // All bus markers
      // if (busLocation?.latitude != null && busLocation?.longitude != null)
      // _BusMarker(bus: busLocation!,busdet: bus!, stoploc: widget.stoploc),
      ...realtmBus!.map((bus) =>
          _BusMarker(bus: bus, busloc: busLocation, busvalue: busvalue)),
    ];

    // 1. Calculate bounds to fit all bus positions
    final allBusPoints = realtmBus!
        .where((b) => b.liveLatitude != null && b.liveLongitude != null)
        .map((b) => LatLng(
              double.parse(b.liveLatitude!),
              double.parse(b.liveLongitude!),
            ))
        .toList();

    // If there are at least 2 points to fit
    if (allBusPoints.length >= 2) {
      final bounds = fmap.LatLngBounds.fromPoints(allBusPoints);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.fitCamera(
          fmap.CameraFit.bounds(
              bounds: bounds, padding: const EdgeInsets.all(50)),
        );
      });
    } else if (allBusPoints.length == 1) {
      // Single bus? Center to it.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.move(allBusPoints.first, 15);
      });
    }

    // Optional: Show popups for all buses on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _popupLayerController.showPopupsOnlyFor(
        _popupMarkers.whereType<_BusMarker>().toList(),
      );
    });
    if (!mounted) return;
    setState(() {});
  }

  void _onBusSelected(String? busId) {
    if (busId == null) return;

    final bus = realtmBus?.firstWhere(
      (b) => b.busId == busId,
      orElse: () => BusDetList(
        busId: '',
        busName: '',
        registrationNo: '',
        busType: '',
        liveLatitude: null,
        liveLongitude: null,
        liveDate: null,
      ),
    );
    if (bus == null) return;

    final lat = double.tryParse(bus.liveLatitude ?? '');
    final lng = double.tryParse(bus.liveLongitude ?? '');

    if (lat != null && lng != null) {
      final markerIndex = _popupMarkers.indexWhere(
          (m) => m is _BusMarker && (m as _BusMarker).bus.busId == busId);

      final marker = _popupMarkers[markerIndex];

      _mapController.move(LatLng(lat, lng), 16);

      Future.delayed(const Duration(milliseconds: 300), () {
        _popupLayerController.showPopupsOnlyFor([marker]);
      });
    }
  }

  fetchRouteForBus(String busid, BuildContext context) async {
    // Cancel previous live update timer
    _busLocationTimer?.cancel();
    _busLocationTimer = null;

    // Clear old data
    _routePoints.clear();
    _popupMarkers.clear();
    stops.clear();
    _lastBusPos = null;
    busLocation = null;
    _popupLayerController.hideAllPopups();

    setState(() => isLoading = true);

    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final usrid = sharedValue!.userId;

    // Find the bus that matches the given busid
    busDetails = realtmBuslist?.firstWhere(
      (bus) => bus.busId == busid,
      orElse: () => BusDetList(), // Provide a fallback empty object
    );

    if (realtmBuslist == null || realtmBuslist!.isEmpty) {
      stopreq = BusListReq(
        userId: usrid,
        busId: busid,
        fromPlace: widget.task?.fromStation ?? '',
        toPlace: widget.task?.toStation ?? '',
        tripId: widget.task?.tripId ?? '',
      );
    } else {
      stopreq = BusListReq(
        userId: usrid,
        busId: busid,
        fromPlace: busDetails?.fromStation ?? '',
        toPlace: busDetails?.toStation ?? '',
        tripId: busDetails?.tripId,
      );
    }

    if (!context.mounted) return;

    final stopValue = await SearchFun.instance.fetchStopLoc(stopreq!, context);
    stops = stopValue?.stops ?? [];
    busLocation = stopValue?.busLocation;
    busvalue = stopValue?.bus;
    if (!mounted) return;
    setState(() => isLoading = false);

    List<LatLng> points = stops
        .map((s) =>
            LatLng(double.parse(s.latitude!), double.parse(s.longitude!)))
        .toList();

    if (points.isNotEmpty) {
      await _fetchRoute(points);
    }

    _buildMarkers();

    if (!mounted) return;
    setState(() {});

    _busLocationTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _fetchBusLiveLocation(busid, context);
    });
    // if(!context.mounted) return;
    //   _fetchBusLiveLocation(busid, context);
  }

  Future<void> _fetchRoute(List<LatLng> points) async {
    final coords = points.map((e) => '${e.longitude},${e.latitude}').join(';');
    final url = Uri.parse(
      'http://pompay.in:5000/route/v1/driving/$coords?overview=full&geometries=geojson',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      final List<LatLng> polylinePoints = List<LatLng>.from(
        geometry['coordinates'].map((coord) => LatLng(coord[1], coord[0])),
      );

      setState(() {
        _routePoints = polylinePoints;
        _isMapReady = false;
      });
    } else {
      log('Failed to fetch route');

      throw Exception('Failed to fetch route');
    }
  }

  Future<void> _fetchBusLiveLocation(String busid, BuildContext context) async {
    final livloc = BusListReq(busId: busid);
    final updated = await SearchFun.instance.fetchLiveBusLoc(livloc, context);
    if (!mounted) return;

    // ------------------------------------------------------------------//
    // 1. Decide which coordinates to use                                //
    // ------------------------------------------------------------------//
    final double busLat, busLng;
    if (updated != null &&
        updated.latitude != null &&
        updated.longitude != null) {
      busLocation = updated;
      busLat = double.parse(updated.latitude!);
      busLng = double.parse(updated.longitude!);
    } else if (_starting != null) {
      busLat = _starting!.latitude;
      busLng = _starting!.longitude;
    } else {
      return; // nothing to show yet
    }
    _lastBusPos = LatLng(busLat, busLng);

    // ------------------------------------------------------------------//
    // 2. Update (or create) the BUS marker                              //
    // ------------------------------------------------------------------//
    _popupMarkers.removeWhere((m) => m.key == const ValueKey('bus_marker'));
    if (busLocation != null) {
      _popupMarkers.add(_BusMarker(
          bus: busDetails!, busloc: busLocation, busvalue: busvalue));
    }

    // ------------------------------------------------------------------//
    // 3. Find NEAREST stop                                              //
    // ------------------------------------------------------------------//
    final Distance hv = const Distance();
    int? nearestDist;
    _StopMarker? nearestStopMarker;

    for (final m in _popupMarkers) {
      if (m is _StopMarker) {
        final d = hv(m.point, _lastBusPos!).round(); // metres
        if (nearestDist == null || d < nearestDist) {
          nearestDist = d;
          nearestStopMarker = m;
        }
      }
    }

    // threshold ≈ 200 m
    // if (nearestStopMarker != null && nearestDist! < 200) {
    //   // Show ONLY that stop’s popup
    //   _popupLayerController.showPopupsOnlyFor([nearestStopMarker]);
    // } else {
    //   _popupLayerController.hideAllPopups();
    // }
    const int stopProximityThreshold = 200;
    if (nearestStopMarker != null) {
      if (nearestDist! < stopProximityThreshold) {
        _popupLayerController.showPopupsOnlyFor([nearestStopMarker]);
      } else if (nearestDist < stopProximityThreshold + 50) {
      } else {
        _popupLayerController.hideAllPopups();
      }
    }

    // ------------------------------------------------------------------//
    // 4. Keep map centred unless user dragged it                        //
    // ------------------------------------------------------------------//
    if (!_isUserInteracting) {
      _mapController.move(_lastBusPos!, 15);
    }

    if (mounted) setState(() {});
  }

  void _updateRouteProgress(LatLng busPos) {
    if (_routePoints.isEmpty) return;

    // Find the nearest route point to the bus
    final nearest = _routePoints
        .reduce((a, b) => _distance(busPos, a) < _distance(busPos, b) ? a : b);

    final index = _routePoints.indexOf(nearest);
    if (index == -1) return;

    setState(() {
      _travelledPoints = _routePoints.sublist(0, index + 1);
      _remainingPoints = _routePoints.sublist(index);
    });
  }

  double _distance(LatLng p1, LatLng p2) {
    final d = Distance();
    return d.as(LengthUnit.Meter, p1, p2);
  }

  void _recenterMap() {
    if (busLocation != null &&
        busLocation!.latitude != null &&
        busLocation!.longitude != null) {
      final position = LatLng(
        double.parse(busLocation!.latitude!),
        double.parse(busLocation!.longitude!),
      );
      _mapController.move(position, 15);
      _isUserInteracting = false;
      setState(() => _showRecenter = false);
    }
  }

  @override
  void dispose() {
    _busLocationTimer?.cancel();
    Livelocationfun.instance.stopTracking();
    super.dispose();
  }

  Future<bool?> popscreen(BuildContext context) async {
    BusTrackFunctions.instance.getRealBusDetailsNotifier.value = [];
    Navigator.pushReplacement(context, Approutes().realBusListScreen);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isMapReady && _routePoints.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, () {
          final bounds = fmap.LatLngBounds.fromPoints(_routePoints);
          _mapController.fitCamera(
            fmap.CameraFit.bounds(
                bounds: bounds, padding: const EdgeInsets.all(50)),
          );
          _isMapReady = true;
        });
      });
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
        log('BackButton pressed!');
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, Approutes().realBusListScreen);
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Track my bus",
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<String>(
                //style: TextStyle(color:Colors.black),
                value: selectedbusId,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withAlpha((0.5 * 255).toInt()),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Select Bus',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 204, 123, 2),
                ),
                onChanged: (selectedbusId) {
                  if (selectedbusId == null) return;

                  final selectedBus = realtmBuslist!.firstWhere(
                    (bus) => bus.busId == selectedbusId,
                    orElse: () => BusDetList(busId: '', tripStatus: '0'),
                  );

                  if (selectedBus.tripStatus == "1") {
                    _onBusSelected(selectedbusId); // Proceed to show on map
                    // You can call your route-fetching function here too
                    fetchRouteForBus(selectedbusId, context);
                  } else {
                    messageBox(context);
                    return;
                  }

                  final lat = double.tryParse(selectedBus.liveLatitude ?? '');
                  final lng = double.tryParse(selectedBus.liveLongitude ?? '');

                  if (lat != null && lng != null) {
                    final marker = _popupMarkers.firstWhere(
                      (m) =>
                          m is _BusMarker &&
                          (m as _BusMarker).bus.busId == selectedbusId,
                      orElse: () => fmap.Marker(
                        point: LatLng(lat, lng),
                        child: const Icon(Icons.location_on),
                      ),
                    );

                    _mapController.move(LatLng(lat, lng), 16);

                    Future.delayed(const Duration(milliseconds: 300), () {
                      _popupLayerController.showPopupsOnlyFor([marker]);
                    });
                  }
                },
                dropdownColor: Colors.white,
                items: realtmBuslist!.map((bus) {
                  final isActive = bus.tripStatus == "1";
                  return DropdownMenuItem<String>(
                    value: bus.busId,
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: isActive ? Colors.green : Colors.red,
                          size: 12,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          bus.registrationNo ?? bus.busName ?? 'Unknown',
                          style: TextStyle(
                            color: isActive ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  fmap.FlutterMap(
                    mapController: _mapController,
                    options: fmap.MapOptions(
                      initialCenter: _starting ?? LatLng(0, 0),
                      initialZoom: 15,
                      minZoom: 5,
                      maxZoom: 18,
                      onTap: (_, __) => _popupLayerController.hideAllPopups(),
                      onPositionChanged: (position, hasGesture) {
                        if (hasGesture) {
                          _isUserInteracting = true;
                          if (!_showRecenter) {
                            setState(() => _showRecenter = true);
                          }
                        }
                      },
                    ),
                    children: [
                      // fmap.TileLayer(
                      //   urlTemplate:
                      //       'https://tile.openstreetmap.org/{z}/{x}/{y}.png?key=Pm9Ul6BqvQ3zxhbRXQ5T',
                      //   userAgentPackageName: 'com.example.pompompay',
                      // ),
                      //   fmap.TileLayer(
                      //   urlTemplate:
                      //     'http://117.221.68.183:7001/tiles/{z}/{x}/{y}.png',
                      //   userAgentPackageName: 'com.example.pompompay',
                      // ),
                      fmap.TileLayer(
                        urlTemplate:
                            'http://pompay.in:7001/tile/{z}/{x}/{y}.png',
                        tileProvider: NetworkTileProvider(),
                        errorTileCallback: (tile, error, stackTrace) {
                          debugPrint('Tile load error: $error │ $tile');
                          log('Tile load error: $error │ $tile');
                        },
                      ),

                      if (_routePoints.isNotEmpty)
                        fmap.PolylineLayer(
                          polylines: [
                            fmap.Polyline(
                              points: _routePoints,
                              color: Colors.blue,
                              strokeWidth: 4,
                            ),
                          ],
                        ),

                      PopupMarkerLayer(
                        options: PopupMarkerLayerOptions(
                          markers: _popupMarkers,
                          popupController: _popupLayerController,
                          popupDisplayOptions: PopupDisplayOptions(
                            builder:
                                (BuildContext context, fmap.Marker marker) {
                              if (marker is _StopMarker) {
                                int? dist;
                                if (_lastBusPos != null) {
                                  dist = const Distance()
                                      .call(marker.point, _lastBusPos!)
                                      .round();
                                }
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(marker.stop.stopName ?? 'Stop'),
                                        if (dist != null) ...[
                                          const SizedBox(height: 4),
                                          Text('Distance ≈ $dist m',
                                              style: const TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              }

                              // if (marker is _BusMarker) {
                              //   return Card(
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Column(
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: [
                              //           Text(marker.bus.busName ?? 'Bus Name'),
                              //           const SizedBox(height: 4),
                              //           Text(
                              //               'Reg No: ${marker.bus.registrationNo ?? 'N/A'}'),
                              //         ],
                              //       ),
                              //     ),
                              //   );
                              // }
                              // ----- BUS MARKER POPUP ----- //
                              if (marker is _BusMarker) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            marker.busvalue?.busName
                                                    ?.toUpperCase() ??
                                                'Bus',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text(
                                            'Reg No: ${marker.busvalue?.registrationNo ?? 'N/A'}'),
                                        const SizedBox(height: 4),
                                        Text(
                                            '${marker.busvalue?.fromStation} → ${marker.busvalue?.toStation}'),
                                        const SizedBox(height: 4),
                                        Text(
                                            '(${marker.busvalue?.startTime ?? 'N/A'}-${marker.busvalue?.endTime ?? 'N/A'})'),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      const CurrentLocationLayer(),
                    ],
                  ),
                  if (_showRecenter)
                    Positioned(
                      bottom: 90,
                      right: 16,
                      child: FloatingActionButton(
                        heroTag: 'recenter',
                        mini: true,
                        onPressed: _recenterMap,
                        child: const Icon(Icons.center_focus_strong),
                      ),
                    ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'mylocation',
          onPressed: () {
            if (_starting != null) {
              _mapController.move(_starting!, 16); // Center to user's location
            }
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
