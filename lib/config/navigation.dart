import 'package:flutter/material.dart';

class Go {
  static void to({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void back({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void off({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void offAll({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}
