import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class BackgroundService {
  BackgroundService._();
  static final instance = BackgroundService._();

  Future<void> initialize() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'bus_announcement',
        channelName: 'Bus Announcement',
        channelDescription: 'Running Bus Announcement',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(3000),
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<bool> checkAndRequestPermissions() async {
    // Check & request notification permission for Android 13+
    NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    // Check location permission before running location-based FGS
    bool hasLocationPermission = await FlutterForegroundTask
        .canDrawOverlays; // or standard location permissions
    return true;
  }

  Future<void> startService() async {
    if (!await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'Bus Announcement Active',
        notificationText: 'Tracking bus route in real-time...',
      );
    }
  }

  Future<void> stopService() async {
    await FlutterForegroundTask.stopService();
  }
}
