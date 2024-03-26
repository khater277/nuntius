import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class TextLastMessage extends StatelessWidget {
  final String message;

  const TextLastMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SecondaryText(
      text: message,
      size: FontSize.s12,
    );
  }
}
