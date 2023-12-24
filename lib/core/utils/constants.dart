import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';

enum Check {
  IN,
  OUT,
}

class Constants {
  static showFlushBar({
    required String title,
    required String message,
    required context,
  }) {
    return Flushbar(
      backgroundColor: AppColors.white,
      titleText: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.black,
              fontSize: FontSize.s14,
            ),
      ),
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.black,
              fontSize: FontSize.s12,
            ),
      ),
      titleColor: AppColors.black,
      messageColor: AppColors.black,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 4),
      icon: const Icon(IconBroken.Danger, color: AppColors.black),
      margin:
          EdgeInsets.symmetric(vertical: AppHeight.h2, horizontal: AppWidth.w3),
      borderRadius: BorderRadius.circular(AppSize.s8),
    )..show(context);
  }

  static TimeOfDay getTime({required int uinxTime}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(uinxTime * 1000);
    TimeOfDay time = TimeOfDay.fromDateTime(date);
    return time;
  }

  static String getDayFromDate({required int dt}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    String dayName = DateFormat('EEEE').format(date);
    return dayName;
  }
}
