import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class ChatNameAndDate extends StatelessWidget {
  final String name;
  final String date;
  const ChatNameAndDate({
    super.key,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LargeHeadText(
            text: name,
            size: FontSize.s13,
          ),
        ),
        SecondaryText(
          text: date,
          size: FontSize.s12,
        ),
      ],
    );
  }
}
