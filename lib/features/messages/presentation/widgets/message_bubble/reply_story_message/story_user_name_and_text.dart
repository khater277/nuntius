import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';

class StoryUserNameAndText extends StatelessWidget {
  final String name;
  final String text;
  final MessageType storyType;
  const StoryUserNameAndText({
    super.key,
    required this.name,
    required this.text,
    required this.storyType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: "$name Story",
            color: AppColors.white,
            size: FontSize.s12,
          ),
          SizedBox(height: AppHeight.h4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                storyType == MessageType.video
                    ? IconBroken.Video
                    : storyType == MessageType.image
                        ? IconBroken.Image
                        : IconBroken.Document,
                color: AppColors.grey,
                size: AppSize.s15,
              ),
              SizedBox(width: AppWidth.w4),
              SecondaryText(
                text: text,
                size: FontSize.s11,
                isButton: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
