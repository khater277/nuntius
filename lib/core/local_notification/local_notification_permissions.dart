import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotificationPermissions {
  Future<bool> isAndroidPermissionGranted();
  Future<void> requestPermissions();
}

class LocalNotificationPermissionsImpl implements LocalNotificationPermissions {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotificationPermissionsImpl(
      {required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin})
      : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
  @override
  Future<bool> isAndroidPermissionGranted() async {
    bool granted = false;
    if (Platform.isAndroid) {
      granted = await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
    return Future.value(granted);
  }

  @override
  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestNotificationsPermission();
      await isAndroidPermissionGranted();
    }
  }
}
