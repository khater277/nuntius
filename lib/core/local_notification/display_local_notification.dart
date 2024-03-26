import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nuntius/core/local_notification/received_notification_model.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

abstract class DisplayLocalNotification {
  Future<void> now({required ReceivedNotification receivedNotification});
  Future<void> schedule({required ReceivedNotification receivedNotification});
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

  @override
  Future<void> schedule(
      {required ReceivedNotification receivedNotification}) async {
    tz.TZDateTime tzDate = tz.TZDateTime.from(
        DateTime.now().add(const Duration(seconds: 20)), tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Hey there',
        'you have scheduled task to do now',
        tzDate,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                icon: "@mipmap/ic_launcher")),
        payload: 'notifications',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
