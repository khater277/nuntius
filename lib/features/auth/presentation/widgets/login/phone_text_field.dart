import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_strings.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/font_styles.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return TextFormField(
            controller: di<AuthCubit>().phoneController,
            autofocus: true,
            readOnly: state == const AuthState.signInWithPhoneNumberLoading(),
            keyboardType: TextInputType.number,
            style: getMediumStyle(
              fontColor: AppColors.white,
              fontSize: FontSize.s16,
              letterSpacing: 3,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AppHeight.h12, horizontal: AppWidth.w8),
              hintText: AppStrings.enterYourNumber,
              hintStyle: getMediumStyle(
                fontColor: AppColors.grey,
                fontSize: FontSize.s13,
                letterSpacing: 1,
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  borderSide: BorderSide(
                    color: AppColors.lightRed,
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  borderSide: BorderSide(
                    color: AppColors.lightRed,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  borderSide: const BorderSide(
                    color: AppColors.lightBlack,
                  )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
                borderSide: const BorderSide(
                  color: AppColors.lightBlack,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
