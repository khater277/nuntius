import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/firebase/fcm/fcm_helper.dart';
import 'package:nuntius/core/local_notification/local_notification_actions.dart';
import 'package:nuntius/core/local_notification/local_notification_permissions.dart';
import 'package:nuntius/core/local_notification/streams/did_receive_local_notification_stream.dart';
import 'package:nuntius/core/local_notification/streams/select_notification_stream.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/features/auth/presentation/screens/login_screen.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/chats/cubit/chats_cubit.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/home/presentation/widgets/app_nav_bar.dart';
import 'package:nuntius/features/home/presentation/widgets/stories_floating_buttons.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';

class HomeScreen extends StatefulWidget {
  final bool fromLogout;
  const HomeScreen({super.key, required this.fromLogout});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (widget.fromLogout) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        di<HomeCubit>().listenToMyData();
        await di<HomeCubit>().getContacts();
        await di<ChatsCubit>().getChats();
        await di<StoriesCubit>().executeAsyncFunctions();
        await di<CallsCubit>().getCalls();
      });
    }
    di<LocalNotificationPermissions>().isAndroidPermissionGranted();
    di<LocalNotificationPermissions>().requestPermissions();
    di<LocalNotificationActions>().click(context: context);
    di<FcmHelper>().onBackgroundMessage(context: context);
    di<FcmHelper>().onForegroundMessage(context: context);
    super.initState();
  }

  @override
  void dispose() {
    di<DidReceiveLocalNotificationStream>().dispose();
    di<SelectNotificationStream>().dispose();
    super.dispose();
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        state.maybeWhen(
          changeNavBar: (index) => _index = index,
          listenToMyData: (myData) async {
            Go.offAll(
                context: context, screen: const LoginScreen(fromLogout: true));
            if (myData == null) {
              await FirebaseAuth.instance.currentUser!.delete();
            }
          },
          orElse: () {},
        );
      },
      buildWhen: (previous, current) => current.maybeWhen(
        listenToMyData: (myData) => false,
        orElse: () => true,
      ),
      builder: (context, state) {
        return state.maybeMap(
          getContactsLoading: (value) => const Scaffold(
            extendBody: true,
            body: Center(
              child: CustomCircleIndicator(),
            ),
          ),
          orElse: () => Scaffold(
            body: di<HomeCubit>().screens[_index],
            extendBody: true,
            bottomNavigationBar: AppBottomNavBar(index: _index),
            floatingActionButton: const StoriesFloatingButtons(),
          ),
        );
      },
    );
  }
}
