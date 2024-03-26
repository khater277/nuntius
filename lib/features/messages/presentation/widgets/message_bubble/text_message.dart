import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: SmallHeadText(
            // text: "${DateTime.parse(message.date!).toUtc()}",
            text: message.message!,
            size: FontSize.s13,
            maxLines: 1000000,
          ),
        ),
        SizedBox(width: AppWidth.w5),
        SecondaryText(
          text: DateFormat.jm().format(DateTime.parse(message.date!).toLocal()),
          color: AppColors.grey,
          size: FontSize.s10,
        )
      ],
    );
  }
}
