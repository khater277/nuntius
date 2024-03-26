import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/widgets/otp/show_otp_text_field.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
