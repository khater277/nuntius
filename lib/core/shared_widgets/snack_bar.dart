import 'package:flutter/material.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/font_styles.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showSnackBar({
  required BuildContext context,
  required String message,
  required Color color,
}) {
  return showTopSnackBar(
    Overlay.of(context),
    padding: EdgeInsets.symmetric(
      vertical: AppHeight.h5,
      horizontal: AppWidth.w5,
    ),
    CustomSnackBar.error(
      message: message,
      backgroundColor: color,
      messagePadding: EdgeInsets.symmetric(horizontal: AppWidth.w10),
      textStyle: getSemiBoldStyle(fontColor: AppColors.white),
    ),
  );
}

errorSnackBar({required BuildContext context, required String errorMsg}) {
  return showSnackBar(
    context: context,
    message: errorMsg,
    color: AppColors.red,
  );
}
