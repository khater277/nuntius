import 'package:flutter/material.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius_/features/auth/presentation/widgets/login/flag_and_country_code.dart';
import 'package:nuntius_/features/auth/presentation/widgets/login/login_head.dart';
import 'package:nuntius_/features/auth/presentation/widgets/login/login_next_button.dart';
import 'package:nuntius_/features/auth/presentation/widgets/login/phone_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    di<AuthCubit>().initPhoneController();
    super.initState();
  }

  @override
  void dispose() {
    di<AuthCubit>().disposePhoneController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppHeight.h60,
              horizontal: AppWidth.w20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHead(),
                SizedBox(height: AppHeight.h100),
                Row(
                  children: [
                    const FlagAndCountryCode(),
                    SizedBox(width: AppWidth.w8),
                    const PhoneTextField()
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const LoginNextButton(),
      ),
    );
  }
}
