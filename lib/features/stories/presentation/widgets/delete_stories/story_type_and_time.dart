import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/my_story/my_story_date.dart';
import 'package:flutter/material.dart';

class StoryTypeAndTime extends StatelessWidget {
  const StoryTypeAndTime({
    super.key,
    required this.date,
    required this.storyType,
  });

  final String date;
  final MessageType storyType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          storyType == MessageType.video
              ? IconBroken.Video
              : storyType == MessageType.image
                  ? IconBroken.Image
                  : IconBroken.Document,
          color: AppColors.blue,
          size: AppSize.s15,
        ),
        SizedBox(height: AppHeight.h3),
        MyStoryDate(
          date: date,
          lighter: true,
        )
      ],
    );
  }
}
