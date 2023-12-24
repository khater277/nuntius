import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/app_theme.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius_/features/auth/presentation/screens/login_screen.dart';
import 'package:nuntius_/features/chats/cubit/chats_cubit.dart';
import 'package:nuntius_/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius_/features/home/cubit/home_cubit.dart';
import 'package:nuntius_/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';

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
                create: (BuildContext context) =>
                    di<HomeCubit>()..getContacts(),
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
              // BlocProvider(
              //   create: (BuildContext context) => di<StoriesCubit>()
              //     ..getPhones(
              //       HomeCubit.get(context).phones.keys.toList(),
              //       HomeCubit.get(context).users,
              //     )
              //     ..getContactsCurrentStories(
              //         users: HomeCubit.get(context).users),
              // ),
              // BlocProvider(
              //   create: (BuildContext context) => di<CallsCubit>(),
              // ),
              // BlocProvider(
              //   create: (BuildContext context) =>
              //       di<ContactsCubit>()..getContacts(context),
              // ),

              // BlocProvider(
              //   create: (BuildContext context) => di<SearchCubit>(),
              // ),
              // BlocProvider(
              //   create: (BuildContext context) => di<EditProfileCubit>(),
              // ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.darkTheme(),
              home: di<UserStorage>().getData() != null
                  ? const HomeScreen()
                  : const LoginScreen(),
              // const HomeScreen(),
              // const LoginScreen(),
            ),
          );
        });
  }
}
