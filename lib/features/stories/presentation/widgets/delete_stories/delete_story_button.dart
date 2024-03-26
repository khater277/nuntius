import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/alert_dialog.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:flutter/material.dart';

class DeleteStoryButton extends StatelessWidget {
  const DeleteStoryButton({super.key, required this.storyModel});

  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoriesCubit, StoriesState>(
      listener: (_, state) {
        state.maybeWhen(
          deleteStoryError: (errorMsg) {
            errorSnackBar(context: context, errorMsg: errorMsg);
            Go.back(context: context);
          },
          deleteStory: () => Go.back(context: context),
          orElse: () {},
        );
      },
      child: IconButton(
        onPressed: () {
          showAlertDialog(
            context: context,
            text: "Are you sure you want to delete this story?",
            okPressed: () =>
                di<StoriesCubit>().deleteStory(storyId: storyModel.id!),
          );
        },
        icon: Icon(
          IconBroken.Delete,
          size: AppSize.s17,
          color: AppColors.blue,
        ),
      ),
    );
  }
}
