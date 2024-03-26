import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/widgets/auth_floating_button.dart';

class LoginNextButton extends StatelessWidget {
  const LoginNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: di<AuthCubit>().phoneController!,
          builder: (BuildContext context, value, Widget? child) {
            return AuthFloatingButton(
              visibleCondition: value.text.length == 11 ||
                  state == const AuthState.signInWithPhoneNumberLoading(),
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
                  debugPrint(di<AuthCubit>().phoneController!.text);
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
