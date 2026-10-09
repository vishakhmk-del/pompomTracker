import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pompomtracker/core/shared_preference/shared_preference_manage.dart';
import 'package:pompomtracker/function/track/search_fun/searchFun.dart';
import 'package:pompomtracker/model/bus_master/bus_list_req/bus_list_req.dart';
import 'package:pompomtracker/model/track/real_bus_det/bus_list.dart';

import 'background_service.dart';
import 'stop_detector.dart';
import 'tts_service.dart';

class AnnouncementService {
  AnnouncementService._();
  static final AnnouncementService instance = AnnouncementService._();

  static const Duration pollingInterval = Duration(seconds: 3);
  static const Duration networkTimeout = Duration(seconds: 8);

  Timer? _timer;
  bool _running = false;
  bool _fetching = false;
  BuildContext? _context;
  BusDetList? _selectedBus;

  bool get isRunning => _running;

  Future<void> start({
    required BuildContext context,
    required BusDetList bus,
  }) async {
    if (_running) return;

    _context = context;
    _selectedBus = bus;

    try {
      await BackgroundService.instance.initialize();
      await BackgroundService.instance.startService();
      await TTSService.instance.initialize();

      final loaded = await _loadStops();
      if (!loaded) {
        await stop();
        return;
      }

      await TTSService.instance.welcome();
      StopDetector.instance.reset();

      _running = true;
      _startPolling();
    } catch (e) {
      await stop();
    }
  }

  Future<void> stop() async {
    _timer?.cancel();
    _timer = null;
    _running = false;
    _fetching = false;
    _selectedBus = null;

    StopDetector.instance.reset();
    await TTSService.instance.stop();
    await BackgroundService.instance.stopService();
  }

  Future<bool> _loadStops() async {
    try {
      final shared = await SharedPrefManager.instance.getSharedData();
      if (shared == null || _selectedBus == null) return false;

      final request = BusListReq(
        userId: shared.userId,
        busId: _selectedBus!.busId,
        tripId: _selectedBus!.tripId,
        fromPlace: _selectedBus!.fromStation,
        toPlace: _selectedBus!.toStation,
      );

      final response =
          await SearchFun.instance.fetchStopLoc(request, _context!);
      if (response?.stops == null || response!.stops!.isEmpty) return false;

      StopDetector.instance.setStops(response.stops!);
      return true;
    } catch (_) {
      return false;
    }
  }

  void _startPolling() {
    _timer?.cancel();
    _timer = Timer.periodic(pollingInterval, (_) => _pollLocation());
  }

  Future<void> _pollLocation() async {
    if (!_running || _fetching || _selectedBus == null) return;

    _fetching = true;

    try {
      final request = BusListReq(
        busId: _selectedBus!.busId,
        tripId: _selectedBus!.tripId,
      );

      final response = await SearchFun.instance
          .fetchLiveBusLoc(request, _context!)
          .timeout(networkTimeout);

      if (response?.latitude != null && response?.longitude != null) {
        final double lat = double.tryParse(response!.latitude!) ?? 0.0;
        final double lng = double.tryParse(response.longitude!) ?? 0.0;

        if (lat != 0.0 && lng != 0.0) {
          final event = StopDetector.instance.check(busLat: lat, busLng: lng);
          if (event != null) {
            _handleEvent(event);
          }

          if (StopDetector.instance.tripFinished) {
            await TTSService.instance.thankYou();
            await stop();
          }
        }
      }
    } catch (_) {
      // Handle network errors gracefully
    } finally {
      _fetching = false;
    }
  }

  void _handleEvent(StopEvent event) {
    switch (event.type) {
      case StopEventType.warning:
        TTSService.instance.speak(
            "Attention please. Bus is approaching ${event.stop.stopName}.");
        break;
      case StopEventType.next:
        TTSService.instance.nextStop(event.stop.stopName ?? '');
        break;
      case StopEventType.arrived:
        TTSService.instance.arriving(event.stop.stopName ?? '');
        break;
    }
  }
}
