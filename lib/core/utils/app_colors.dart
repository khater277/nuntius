import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xff1C1B1B);
  static const Color offWhite = Color(0xffF2F2F2);
  static const Color grey = Color(0xffCCCCCC);
  static const Color white = Color(0xffFFFFFF);
  static const Color blue = Color(0xff007EF4);
  static const Color lightBlack = Color(0xff2B2B2B);
  static const Color darkBlack = Color(0xff1F1F1F);
  static const Color red = Colors.red;
  static final Color lightRed = Colors.red.withOpacity(0.4);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
