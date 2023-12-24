import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/home/presentation/widgets/stories_fab.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/presentation/screens/add_text_story_screen.dart';
import 'package:flutter/material.dart';

class StoriesFloatingButtons extends StatelessWidget {
  const StoriesFloatingButtons({
    super.key,
    required this.storiesCubit,
  });

  final StoriesCubit storiesCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StoriesFab(
          onPressed: () {
            Go.to(context: context, screen: const AddTextStoryScreen());
          },
          icon: IconBroken.Edit,
          tag: "btn1",
        ),
        SizedBox(height: AppHeight.h6),
        StoriesFab(
          onPressed: () {
            storiesCubit.pickStoryImage();
          },
          icon: IconBroken.Image,
          tag: "btn2",
        ),
        SizedBox(height: AppHeight.h6),
        StoriesFab(
          onPressed: () {
            storiesCubit.pickStoryVideo();
          },
          icon: IconBroken.Video,
          tag: "btn3",
        ),
      ],
    );
  }
}
