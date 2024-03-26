import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_functions.dart';
import 'package:flutter/material.dart';

class MyStoryDate extends StatefulWidget {
  final String date;
  final bool lighter;
  const MyStoryDate({super.key, required this.date, this.lighter = false});

  @override
  State<MyStoryDate> createState() => _MyStoryDateState();
}

class _MyStoryDateState extends State<MyStoryDate> {
  Stream stream = Stream.periodic(const Duration(seconds: 1), (a) => a);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return SmallHeadText(
            text: AppFunctions.storyDate(widget.date),
            color: widget.lighter
                ? AppColors.grey.withOpacity(0.7)
                : AppColors.grey,
            size: FontSize.s11,
          );
        });
  }
}
