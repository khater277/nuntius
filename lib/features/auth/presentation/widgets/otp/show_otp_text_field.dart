import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ShowOtpTextField extends StatelessWidget {
  const ShowOtpTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      autoFocus: true,
      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: FontSize.s15,
          ),
      cursorColor: AppColors.white,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(AppSize.s5),
          fieldHeight: AppHeight.h50,
          fieldWidth: AppWidth.w40,
          borderWidth: AppSize.s1,
          activeFillColor: AppColors.black.withOpacity(0.7),
          activeColor: AppColors.grey.withOpacity(0.3),
          inactiveColor: Colors.blue.withOpacity(0.4),
          selectedFillColor: AppColors.blue.withOpacity(0.2),
          selectedColor: AppColors.blue.withOpacity(0.5),
          disabledColor: Colors.blue.withOpacity(0.4),
          inactiveFillColor: AppColors.black.withOpacity(0.7)),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      enableActiveFill: true,
      onCompleted: (smsCode) {
        di<AuthCubit>().submitOtp(smsCode);

        // setState(() {
        //   otp = smsCode;
        // });
      },
      onChanged: (value) {
        debugPrint(value);
      },
    );
  }
}
