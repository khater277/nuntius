import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class CallStatusText extends StatelessWidget {
  final String text;
  const CallStatusText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryText(
      text: text,
      isButton: true,
      size: FontSize.s13,
    );
  }
}
