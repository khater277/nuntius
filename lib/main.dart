import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/app/app.dart';
import 'package:nuntius/app/bloc_observer.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_notification/local_notification_initializer.dart';
import 'package:nuntius/core/local_storage/all_users_storage.dart';
import 'package:nuntius/core/local_storage/calls_storage.dart';
import 'package:nuntius/core/local_storage/chats_storage.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius/features/home/data/models/notification_data/notification_data.dart';
import 'package:nuntius/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final data = NotificationData.fromJson(message.data);
  debugPrint("Handling a background message from : ${data.phoneNumber}");
}

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  final x = await FirebaseMessaging.instance.getToken();
  debugPrint(x);
  await SharedPrefHelper.init();
  await Hive.initFlutter();
  await di<UserStorage>().init();
  await di<AllUsersStorage>().init();
  await di<ChatsStorage>().init();
  await di<CallsStorage>().init();
  await Permission.contacts.request();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  tz.initializeTimeZones();
  await di<LocalNotificationInitializer>().init();
  runApp(const MyApp());
}
