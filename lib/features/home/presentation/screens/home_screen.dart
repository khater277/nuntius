import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/local_notification/local_notification_actions.dart';
import 'package:nuntius_/core/local_notification/local_notification_permissions.dart';
import 'package:nuntius_/core/local_notification/streams/did_receive_local_notification_stream.dart';
import 'package:nuntius_/core/local_notification/streams/select_notification_stream.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/features/home/cubit/home_cubit.dart';
import 'package:nuntius_/features/home/presentation/widgets/app_nav_bar.dart';
import 'package:nuntius_/features/home/presentation/widgets/stories_floating_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // FcmHelper.handleForegroundNotification(
    //     homeCubit: HomeCubit.get(context), context: context);
    // FcmHelper.handelBackgroundNotification(
    //     homeCubit: HomeCubit.get(context), context: context);
    di<LocalNotificationPermissions>().isAndroidPermissionGranted();
    di<LocalNotificationPermissions>().requestPermissions();
    di<LocalNotificationActions>().click();
    // NotificationsHelper.configureDidReceiveLocalNotificationSubject(context);
    // NotificationsHelper.configureSelectNotificationSubject(
    //   ChatsCubit.get(context),
    //   context,
    // );
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
          orElse: () {},
        );
      },
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
