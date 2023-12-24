import 'package:flutter/foundation.dart';
import 'package:nuntius_/core/local_notification/streams/select_notification_stream.dart';

abstract class LocalNotificationActions {
  void click();
}

class LocalNotificationActionsImpl implements LocalNotificationActions {
  final SelectNotificationStream _selectNotificationStream;
  LocalNotificationActionsImpl({
    required SelectNotificationStream selectNotificationStream,
  }) : _selectNotificationStream = selectNotificationStream;

  @override
  void click() {
    _selectNotificationStream.stream.listen((String? payload) {
      debugPrint("payload============>$payload");
    });
  }
}
