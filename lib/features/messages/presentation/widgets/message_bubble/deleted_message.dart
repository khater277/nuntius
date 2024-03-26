import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeletedMessage extends StatelessWidget {
  const DeletedMessage({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    // VideoThumbnail
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: SmallHeadText(
            text: "this message was deleted.",
            size: FontSize.s13,
            color: AppColors.grey,
            italic: true,
          ),
        ),
        SizedBox(width: AppWidth.w5),
        SecondaryText(
          text: DateFormat.jm().format(DateTime.parse(date).toLocal()),
          color: AppColors.grey,
          size: FontSize.s10,
        )
      ],
    );
  }
}
