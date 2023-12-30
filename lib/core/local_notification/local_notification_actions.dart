import 'package:flutter/material.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/local_notification/streams/select_notification_stream.dart';
import 'package:nuntius_/features/messages/presentation/screens/messages_screen.dart';

abstract class LocalNotificationActions {
  void click({required BuildContext context});
}

class LocalNotificationActionsImpl implements LocalNotificationActions {
  final SelectNotificationStream _selectNotificationStream;
  LocalNotificationActionsImpl({
    required SelectNotificationStream selectNotificationStream,
  }) : _selectNotificationStream = selectNotificationStream;

  @override
  void click({required BuildContext context}) {
    _selectNotificationStream.stream.listen((String? phoneNumber) {
      Go.to(
          context: context, screen: MessagesScreen(phoneNumber: phoneNumber!));
    });
  }
}
