import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class MediaLastMessage extends StatelessWidget {
  final IconData icon;
  final String name;
  const MediaLastMessage({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppSize.s15,
          color: AppColors.blue,
        ),
        SizedBox(width: AppWidth.w5),
        SecondaryText(
          text: name,
          size: FontSize.s12,
        ),
      ],
    );
  }
}
