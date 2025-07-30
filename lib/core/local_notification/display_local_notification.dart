import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nuntius/core/local_notification/received_notification_model.dart';
// ignore: depend_on_referenced_packages

abstract class DisplayLocalNotification {
  Future<void> now({required ReceivedNotification receivedNotification});
}

class DisplayLocalNotificationImpl implements DisplayLocalNotification {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  DisplayLocalNotificationImpl(
      {required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin})
      : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;

  @override
  Future<void> now({required ReceivedNotification receivedNotification}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().show(
      receivedNotification.id,
      receivedNotification.title,
      receivedNotification.body,
      platformChannelSpecifics,
      payload: receivedNotification.payload,
    );
  }
}
