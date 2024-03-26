import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/screens/otp_screen.dart';
import 'package:nuntius/features/auth/presentation/widgets/login/flag_and_country_code.dart';
import 'package:nuntius/features/auth/presentation/widgets/login/login_head.dart';
import 'package:nuntius/features/auth/presentation/widgets/login/login_next_button.dart';
import 'package:nuntius/features/auth/presentation/widgets/login/phone_text_field.dart';

class LoginScreen extends StatefulWidget {
  final bool fromLogout;
  const LoginScreen({super.key, required this.fromLogout});

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
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            codeSent: () => Go.to(
              context: context,
              screen: OtpScreen(
                phoneNumber: di<AuthCubit>().phoneController!.text,
                fromLogout: widget.fromLogout,
              ),
            ),
            errorState: (errorMsg) =>
                errorSnackBar(context: context, errorMsg: errorMsg),
            orElse: () {},
          );
        },
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
      ),
    );
  }
}
