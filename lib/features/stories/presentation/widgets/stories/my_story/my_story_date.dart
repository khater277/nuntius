import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_functions.dart';
import 'package:flutter/material.dart';

class MyStoryDate extends StatelessWidget {
  final String date;
  final bool lighter;
  const MyStoryDate({super.key, required this.date, this.lighter = false});

  @override
  Widget build(BuildContext context) {
    Stream stream = Stream.periodic(const Duration(seconds: 1), (a) => a);
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return SmallHeadText(
            text: AppFunctions.storyDate(date),
            color: lighter ? AppColors.grey.withOpacity(0.7) : AppColors.grey,
            size: FontSize.s11,
          );
        });
  }
}
