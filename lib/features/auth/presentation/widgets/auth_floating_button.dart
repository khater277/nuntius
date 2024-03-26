import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_strings.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFloatingButton extends StatelessWidget {
  const AuthFloatingButton({
    super.key,
    required this.visibleCondition,
    required this.loadingCondition,
    required this.onPressed,
  });

  final bool visibleCondition;
  final bool loadingCondition;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (visibleCondition) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (!loadingCondition) {
                onPressed();
              }
            },
            label: loadingCondition
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppWidth.w15),
                    child: CustomCircleIndicator(
                      color: AppColors.black,
                      size: AppSize.s20,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
                    child: Row(
                      children: [
                        SmallHeadText(
                          text: AppStrings.next,
                          color: AppColors.black,
                          size: FontSize.s15,
                        ),
                        SizedBox(width: AppWidth.w4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                          size: AppSize.s12,
                        )
                      ],
                    ),
                  ),
            backgroundColor: AppColors.white,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
