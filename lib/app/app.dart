import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/app_theme.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/screens/login_screen.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/chats/cubit/chats_cubit.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/home/presentation/screens/home_screen.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/search/cubit/search_cubit.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => di<AuthCubit>(),
              ),
              BlocProvider(
                create: (BuildContext context) => di<HomeCubit>()
                  ..listenToMyData()
                  ..getContacts(),
              ),
              BlocProvider(
                create: (BuildContext context) => di<ContactsCubit>(),
              ),
              BlocProvider(
                create: (BuildContext context) => di<MessagesCubit>(),
              ),
              BlocProvider(
                create: (BuildContext context) => di<ChatsCubit>()..getChats(),
              ),
              BlocProvider(
                create: (BuildContext context) => di<SearchCubit>(),
              ),
              BlocProvider(
                create: (BuildContext context) => di<EditProfileCubit>(),
              ),
              BlocProvider(
                  create: (BuildContext context) =>
                      di<StoriesCubit>()..executeAsyncFunctions()),
              BlocProvider(
                create: (BuildContext context) => di<CallsCubit>()..getCalls(),
              ),
              // BlocProvider(
              //   create: (BuildContext context) =>
              //       di<ContactsCubit>()..getContacts(context),
              // ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.darkTheme(),
              home: di<UserStorage>().getUser() != null
                  ? const HomeScreen(fromLogout: false)
                  : const LoginScreen(fromLogout: false),
              // const HomeScreen(),
              // const LoginScreen(),
            ),
          );
        });
  }
}
