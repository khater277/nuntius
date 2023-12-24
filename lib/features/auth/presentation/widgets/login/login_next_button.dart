import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius_/features/auth/presentation/screens/otp_screen.dart';
import 'package:nuntius_/features/auth/presentation/widgets/auth_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginNextButton extends StatelessWidget {
  const LoginNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          codeSent: () => Go.to(
            context: context,
            screen: OtpScreen(
              phoneNumber: di<AuthCubit>().phoneController!.text,
            ),
          ),
          errorState: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: di<AuthCubit>().phoneController!,
          builder: (BuildContext context, value, Widget? child) {
            return AuthFloatingButton(
              visibleCondition: value.text.length == 11,
              loadingCondition:
                  state == const AuthState.signInWithPhoneNumberLoading(),
              onPressed: () {
                String? msg;
                if (value.text.startsWith('01') == false) {
                  msg = "incorrect number";
                }
                if (msg != null) {
                  showSnackBar(
                    context: context,
                    message: msg,
                    color: AppColors.red,
                  );
                } else {
                  print(di<AuthCubit>().phoneController!.text);
                  di<AuthCubit>().signInWithPhoneNumber();
                }
              },
            );
          },
        );
      },
    );
  }
}
