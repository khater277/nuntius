import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/local_notification/display_local_notification.dart';
import 'package:nuntius/core/local_notification/received_notification_model.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_sounds.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/data/models/live_call_data.dart';
import 'package:nuntius/features/calls/presentation/screens/receive_call_screen.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/home/data/models/notification_data/notification_data.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/presentation/screens/messages_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

abstract class FcmHelper {
  void onForegroundMessage({required BuildContext context});
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
          screen: MessagesScreen(
            phoneNumber: data.phoneNumber,
          ));
    });
  }

  @override
  void onForegroundMessage({required BuildContext context}) {
    FirebaseMessaging.onMessage.listen((message) async {
      final data = NotificationData.fromJson(message.data);
      final user = di<HomeCubit>()
              .users
              .firstWhereOrNull((element) => element.uId == data.senderID) ??
          UserData(
            name: data.phoneNumber,
            image: "",
          );
      switch (data.type) {
        case NotificationType.message:
          await _onReceiveNewMessage(message);
          break;
        case NotificationType.receiveCall:
          if (DateTime.parse(data.notificationDate)
              .toLocal()
              .isAfter(DateTime.now())) {
            _onReceiveCall(context, data, user);
          }
          break;
        case NotificationType.cancelCall:
          di<CallsCubit>().cancelCall();
          break;
        // case NotificationType.joinCall:
        //   di<CallsCubit>().remoteUserJoined();
        //   break;
        default:
          await _onReceiveNewMessage(message);
          break;
      }
    });
  }

  void _onReceiveCall(
      BuildContext context, NotificationData data, UserData user) {
    debugPrint("AAAAAA");
    Go.to(
      context: context,
      screen: ReceiveCallScreen(
        liveCallData: LiveCallData(
          userToken: data.userToken!,
          rtcToken: data.token!,
          channelName: data.channelName!,
          image: user.image!,
          name: user.name!,
          phoneNumber: data.phoneNumber,
          callType: data.callType!,
          receiveCall: true,
          receiveCallEndDate: DateTime.parse(data.notificationDate).toLocal(),
        ),
      ),
    );
  }

  Future<void> _onReceiveNewMessage(RemoteMessage message) async {
    final data = NotificationData.fromJson(message.data);
    if (messagesCubit.user != null) {
      if (messagesCubit.user!.uId == data.senderID) {
        final receiveMessagePlayer = AudioPlayer();
        await receiveMessagePlayer.setAsset(AppSounds.receiveMessage);
        await receiveMessagePlayer.play();
      } else {
        displayLocalNotification.now(
          receivedNotification: ReceivedNotification(
            id: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
            title: "New Message",
            body: "${data.senderName} sent you new message.",
            payload: data.phoneNumber,
          ),
        );
      }
    } else {
      displayLocalNotification.now(
        receivedNotification: ReceivedNotification(
          id: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
          title: "New Message",
          body: "${data.senderName} sent you new message.",
          payload: data.phoneNumber,
        ),
      );
    }
  }
}
