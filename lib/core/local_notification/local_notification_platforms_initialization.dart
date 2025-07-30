import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nuntius/core/local_notification/streams/did_receive_local_notification_stream.dart';

abstract class LocalNotificationPlatformInitialization {
  AndroidInitializationSettings initAndroid();
  DarwinInitializationSettings initIos();
}

class LocalNotificationPlatformInitializationImpl
    implements LocalNotificationPlatformInitialization {
  final DidReceiveLocalNotificationStream _didReceiveLocalNotificationStream;
  LocalNotificationPlatformInitializationImpl(
      {required DidReceiveLocalNotificationStream
          didReceiveLocalNotificationStream})
      : _didReceiveLocalNotificationStream = didReceiveLocalNotificationStream;

  @override
  AndroidInitializationSettings initAndroid() {
    return const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
  }

  @override
  DarwinInitializationSettings initIos() {
    return DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: [
        DarwinNotificationCategory(
          'textCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.text(
              'text_1',
              'Action 1',
              buttonTitle: 'Send',
              placeholder: 'Placeholder',
            ),
          ],
        ),
        DarwinNotificationCategory(
          'plainCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2 (destructive)',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3 (foreground)',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
            DarwinNotificationAction.plain(
              'id_4',
              'Action 4 (auth required)',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.authenticationRequired,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
    );
  }
}
