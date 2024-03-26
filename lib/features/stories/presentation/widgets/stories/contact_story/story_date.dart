import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_functions.dart';
import 'package:flutter/material.dart';

class StoryDate extends StatelessWidget {
  final String storyDate;
  const StoryDate({super.key, required this.storyDate});

  @override
  Widget build(BuildContext context) {
    Stream stream = Stream.periodic(const Duration(seconds: 1), (a) => a);
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          String date = AppFunctions.storyDate(storyDate);
          return SmallHeadText(
            text: date,
            color: AppColors.grey,
            size: FontSize.s11,
          );
        });
  }
}
