import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/app.dart';
import 'package:nuntius_/app/bloc_observer.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/local_notification/local_notification_initializer.dart';
import 'package:nuntius_/core/local_storage/all_users_storage.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius_/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:hive_flutter/hive_flutter.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  final user = di<AllUsersStorage>().getData();
  //     .firstWhereOrNull((element) => element.uId == message.data['senderID']);
  // final name = user   == null ? message.data['phoneNumber'] : user.name!;

  print("Handling a background message from : $user");
}

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  final x = await FirebaseMessaging.instance.getToken();
  print(x);
  await SharedPrefHelper.init();
  await Hive.initFlutter();
  await di<UserStorage>().init();
  await di<AllUsersStorage>().init();
  await Permission.contacts.request();
  Bloc.observer = MyBlocObserver();
  tz.initializeTimeZones();
  await di<LocalNotificationInitializer>().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}
