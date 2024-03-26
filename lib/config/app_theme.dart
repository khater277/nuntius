import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/font_styles.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: AppColors.generateMaterialColor(AppColors.blue),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
        elevation: 0,
        // shape: RoundedRectangleBorder(),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: getSemiBoldStyle(fontColor: Colors.white),
        bodyMedium: getMediumStyle(fontColor: Colors.white),
        bodySmall: getRegularStyle(fontColor: Colors.white.withOpacity(0.5)),
      ),
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: AppColors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            statusBarColor: AppColors.black,
          ),
          titleTextStyle: TextStyle(
              fontFamily: 'SF-Pro-Display',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          )),
      cardColor: AppColors.black,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: AppColors.darkBlack,
        type: BottomNavigationBarType.fixed,
      ),

      ///card
      cardTheme: CardTheme(
        elevation: 0,
        color: AppColors.lightBlack,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
      ),

      /// elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.white,
        textStyle: getMediumStyle(
          fontColor: AppColors.white,
          fontSize: FontSize.s15,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s20)),
        minimumSize: Size(double.infinity, AppHeight.h45),
      )),

      /// text button
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.blue)),

      /// input decoration
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: getRegularStyle(
          fontColor: AppColors.grey.withOpacity(0.6),
        ),
        fillColor: AppColors.lightBlack,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
            vertical: AppHeight.h2, horizontal: AppWidth.w12),
        errorStyle: getRegularStyle(
            fontColor: AppColors.lightRed, fontSize: FontSize.s12),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s20),
            borderSide: BorderSide(
              color: AppColors.lightRed,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s20),
            borderSide: BorderSide(
              color: AppColors.lightRed,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s20),
            borderSide: const BorderSide(
              color: AppColors.lightBlack,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: const BorderSide(
            color: AppColors.lightBlack,
          ),
        ),
      ),
    );
  }
}
