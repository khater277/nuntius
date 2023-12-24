import 'dart:async';
import 'package:nuntius_/core/local_notification/received_notification_model.dart';

class DidReceiveLocalNotificationStream {
  final _controller = StreamController<ReceivedNotification>.broadcast();

  Stream<ReceivedNotification> get stream => _controller.stream;
  void addToStream(ReceivedNotification data) {
    _controller.sink.add(data);
  }

  void dispose() {
    _controller.close();
  }
}
