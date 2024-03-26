import 'package:flutter/material.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';

class ControlCallButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final Color backgroundColor;
  final bool loadingCondition;
  const ControlCallButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    this.loadingCondition = false,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: icon,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: loadingCondition
          ? CustomCircleIndicator(
              color: AppColors.white,
              size: AppSize.s18,
              strokeWidth: 1,
            )
          : Icon(
              icon,
              color: AppColors.white,
            ),
    );
  }
}
