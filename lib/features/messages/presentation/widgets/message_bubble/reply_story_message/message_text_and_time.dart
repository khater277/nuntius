import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTextAndTime extends StatelessWidget {
  final String message;
  const MessageTextAndTime({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: AppWidth.w4),
        SmallHeadText(
          text: message,
          size: FontSize.s13,
          maxLines: 1000000,
        ),
        SizedBox(width: AppWidth.w4),
        const Spacer(),
        SecondaryText(
          text:
              DateFormat.jm().format(DateTime.parse(DateTime.now().toString())),
          color: AppColors.grey,
          size: FontSize.s10,
        ),
        SizedBox(width: AppWidth.w4),
      ],
    );
  }
}
