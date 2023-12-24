import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius_/features/auth/presentation/screens/set_image_screen.dart';
import 'package:nuntius_/features/auth/presentation/widgets/otp/show_otp_text_field.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          submitOtp: () => Go.offAll(
            context: context,
            screen: const SetImageScreen(),
          ),
          errorState: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          submitOtpLoading: () => Center(
            child: CustomCircleIndicator(
              color: AppColors.blue,
              size: AppSize.s40,
            ),
          ),
          orElse: () => const ShowOtpTextField(),
        );
      },
    );
  }
}
