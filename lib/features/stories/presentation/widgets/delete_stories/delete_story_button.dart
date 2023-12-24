import 'package:nuntius_/core/shared_widgets/alert_dialog.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/data/models/story_model/story_model.dart';
import 'package:flutter/material.dart';

class DeleteStoryButton extends StatelessWidget {
  const DeleteStoryButton({super.key, required this.storyModel});

  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlertDialog(
          context: context,
          text: "Are you sure you want to delete this story?",
          okPressed: () =>
              StoriesCubit.get(context).deleteStory(storyId: storyModel.id!),
        );
      },
      child: Icon(
        IconBroken.Delete,
        size: AppSize.s17,
        color: AppColors.blue,
      ),
    );
  }
}
