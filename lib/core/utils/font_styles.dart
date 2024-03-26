import 'package:flutter/material.dart';
import 'package:nuntius/core/utils/app_fonts.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required String fontFamily,
  required FontWeight fontWeight,
  required Color fontColor,
  double? letterSpacing,
}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: fontColor,
      letterSpacing: letterSpacing);
}

///Bold font style
TextStyle getBoldStyle(
    {double? fontSize, required Color fontColor, double? letterSpacing}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.bold,
      fontColor: fontColor,
      letterSpacing: letterSpacing);
}

///SemiBold font style
TextStyle getSemiBoldStyle(
    {double? fontSize, required Color fontColor, double? letterSpacing}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.semiBold,
      fontColor: fontColor,
      letterSpacing: letterSpacing);
}

///Medium font style
TextStyle getMediumStyle(
    {double? fontSize, required Color fontColor, double? letterSpacing}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.medium,
      fontColor: fontColor,
      letterSpacing: letterSpacing);
}

///Regular font style
TextStyle getRegularStyle(
    {double? fontSize, required Color fontColor, double? letterSpacing}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.regular,
      fontColor: fontColor,
      letterSpacing: letterSpacing);
}

///Light font style
TextStyle getLightStyle(
    {double? fontSize, required Color fontColor, double? letterSpacing}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.light,
      fontColor: fontColor,
      letterSpacing: letterSpacing);
}
