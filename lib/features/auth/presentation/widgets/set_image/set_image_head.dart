import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

class SetImageHead extends StatelessWidget {
  const SetImageHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: "Hey ",
                  style: textSpanStyle(context),
                  children: [
                TextSpan(
                    text: di<AuthCubit>().phoneController!.text,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: FontSize.s15, color: AppColors.blue)),
                TextSpan(
                    text: " , please select your profile image",
                    style: textSpanStyle(context))
              ])),
        ],
      ),
    );
  }

  TextStyle textSpanStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontSize: FontSize.s15, color: AppColors.grey, height: 1.5);
  }
}
