import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class TextStoryInsideCircle extends StatelessWidget {
  final String text;
  const TextStoryInsideCircle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w2),
      child: PrimaryText(
        text: text,
        color: AppColors.white,
        size: FontSize.s10,
        maxLines: 3,
        center: true,
      ),
    );
  }
}
