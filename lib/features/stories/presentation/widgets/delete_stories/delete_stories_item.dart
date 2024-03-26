import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/presentation/widgets/delete_stories/delete_story_button.dart';
import 'package:nuntius/features/stories/presentation/widgets/delete_stories/story_content.dart';
import 'package:nuntius/features/stories/presentation/widgets/delete_stories/story_type_and_time.dart';

class DeleteStoriesItem extends StatelessWidget {
  final StoryModel storyModel;
  const DeleteStoriesItem({super.key, required this.storyModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StoryContent(
          storyModel: storyModel,
          videoThumbnail: di<StoriesCubit>().videosThumbnails[storyModel.id],
        ),
        SizedBox(width: AppWidth.w8),
        StoryTypeAndTime(
          date: storyModel.date!,
          storyType: storyModel.isImage == true
              ? MessageType.image
              : storyModel.isVideo == true
                  ? MessageType.video
                  : MessageType.doc,
        ),
        const Spacer(),
        DeleteStoryButton(storyModel: storyModel)
      ],
    );
  }
}
