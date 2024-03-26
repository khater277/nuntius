import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';

class DeletedLastMessage extends StatelessWidget {
  const DeletedLastMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SecondaryText(
          text: "this message was deleted",
          size: FontSize.s12,
          italic: true,
        ),
        SizedBox(width: AppWidth.w4),
        Icon(
          IconBroken.Delete,
          color: Colors.red,
          size: AppSize.s13,
        ),
      ],
    );
  }
}
