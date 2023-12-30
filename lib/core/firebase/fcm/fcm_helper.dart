import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/local_notification/display_local_notification.dart';
import 'package:nuntius_/core/local_notification/received_notification_model.dart';
import 'package:nuntius_/core/utils/app_sounds.dart';
import 'package:nuntius_/features/home/data/models/notification_data/notification_data.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius_/features/messages/presentation/screens/messages_screen.dart';

abstract class FcmHelper {
  void onForegroundMessage();
  void onBackgroundMessage({required BuildContext context});
}

class FcmHelperImpl implements FcmHelper {
  final MessagesCubit messagesCubit;
  final DisplayLocalNotification displayLocalNotification;

  FcmHelperImpl(
      {required this.messagesCubit, required this.displayLocalNotification});
  @override
  void onBackgroundMessage({required BuildContext context}) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final data = NotificationData.fromJson(message.data);
      Go.to(
          context: context,
          screen: MessagesScreen(phoneNumber: data.phoneNumber!));
    });
  }

  @override
  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((message) async {
      final data = NotificationData.fromJson(message.data);
      if (messagesCubit.user != null) {
        if (messagesCubit.user!.uId == data.senderId) {
          final receiveMessagePlayer = AudioPlayer();
          await receiveMessagePlayer.setAsset(AppSounds.receiveMessage);
          await receiveMessagePlayer.play();
        } else {
          displayLocalNotification.now(
            receivedNotification: ReceivedNotification(
              id: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
              title: "New Message",
              body: "${data.name} sent you new message.",
              payload: data.phoneNumber,
            ),
          );
        }
      } else {
        displayLocalNotification.now(
          receivedNotification: ReceivedNotification(
            id: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
            title: "New Message",
            body: "${data.name} sent you new message.",
            payload: data.phoneNumber,
          ),
        );
      }
    });
  }
}
