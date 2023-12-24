import 'package:collection/collection.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/calls/data/models/call_notification_data/call_data.dart';
import 'package:nuntius_/features/calls/presentation/screens/receive_call_screen.dart';
import 'package:nuntius_/features/home/cubit/home_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmHelper {
  static void handleForegroundNotification({
    required HomeCubit homeCubit,
    required BuildContext context,
  }) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      print('Message also contained a notification: ${message.notification}');
      UserData? userModel = homeCubit.users.firstWhereOrNull(
          (element) => element.uId == message.data['senderID']);
      String? name =
          userModel != null ? userModel.name! : message.data['phoneNumber'];
      print("${message.data['type']}");
      if (message.data['type'] == 'message') {
        int id = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
        // print(
        //     "=============================>A7A${(homeCubit.user == null) || (homeCubit.user!.uId != message.data['senderID'])}");
        // if ((homeCubit.user == null) ||
        //     (homeCubit.user!.uId != message.data['senderID'])) {
        //   // print(
        //   //     "=============================>A7A${(homeCubit.user == null) || (homeCubit.user!.uId != message.data['senderID'])}");
        //   di<DisplayLocalNotification>().now(
        //       receivedNotification: ReceivedNotification(
        //     id: id,
        //     title: "New Message",
        //     body: "$name sent you a new message.",
        //     payload: "payload",
        //   ));
        //   // NotificationsHelper.showNotification(
        //   //     id: id, name: name!, senderID: message.data['senderID']);
        // } else if ((homeCubit.user!.uId == message.data['senderID'])) {
        //   final receiveMessagePlayer = AudioPlayer();
        //   await receiveMessagePlayer.setAsset(AppSounds.receiveMessage);
        //   Future.delayed(const Duration(milliseconds: 500))
        //       .then((value) => receiveMessagePlayer.play());
        // }
      } else if (message.data['type'] == 'call') {
        CallData callData = CallData.fromJson(message.data);
        print("=======================>${callData.userToken!}");
        Go.to(
            context: context,
            screen: ReceiveCallScreen(
              userToken: callData.userToken!,
              rtcToken: callData.token!,
              channelName: callData.channelName!,
              image: userModel == null ? "" : userModel.image!,
              name: name!,
              phoneNumber: callData.phoneNumber!,
              callType: callData.callType == 'voice'
                  ? CallType.voice
                  : CallType.video,
            ));
      }
    });
  }

  static void handelBackgroundNotification(
      {required HomeCubit homeCubit, required BuildContext context}) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("sender=================>${message.data['senderID']}");
      UserData? user = homeCubit.users.firstWhereOrNull(
          (element) => element.uId == message.data['senderID']);
      // if (user == null) {
      //   // homeCubit.getChats(context);
      //   user = homeCubit.users.firstWhereOrNull(
      //       (element) => element.uId == message.data['senderID']);
      //   Go.to(context: context, screen: MessagesScreen(user: user!));
      //   // Get.to(() => MessagesScreen(user: user!, isFirstMessage: false));
      // } else {
      //   Go.to(context: context, screen: MessagesScreen(user: user));
      //   // Get.to(() => MessagesScreen(user: user!, isFirstMessage: false));
      // }
    });
  }
}
