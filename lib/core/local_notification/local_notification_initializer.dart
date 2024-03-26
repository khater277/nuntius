import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nuntius/core/local_notification/local_notification_platforms_initialization.dart';
import 'package:nuntius/core/local_notification/streams/select_notification_stream.dart';

abstract class LocalNotificationInitializer {
  Future<void> init();
}

class LocalNotificationInitializerImpl implements LocalNotificationInitializer {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final SelectNotificationStream _selectNotificationStream;
  final LocalNotificationPlatformInitialization
      _localNotificationPlatformInitialization;
  LocalNotificationInitializerImpl(
      {required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      required SelectNotificationStream selectNotificationStream,
      required LocalNotificationPlatformInitialization
          localNotificationPlatformInitialization})
      : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        _selectNotificationStream = selectNotificationStream,
        _localNotificationPlatformInitialization =
            localNotificationPlatformInitialization;
  @override
  Future<void> init() async {
    await _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: _localNotificationPlatformInitialization.initAndroid(),
        iOS: _localNotificationPlatformInitialization.initIos(),
      ),
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _selectNotificationStream.addToStream(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            const String navigationActionId = 'id_3';
            if (notificationResponse.actionId == navigationActionId) {
              _selectNotificationStream
                  .addToStream(notificationResponse.payload);
            }
            break;
        }
      },
    );
  }
}
