import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/my_story_viewers/my_story_viewers.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/reply_to_story/reply_to_story.dart';
import 'package:story_view/story_view.dart';

class StoryViewBody extends StatelessWidget {
  const StoryViewBody({
    super.key,
    required this.stories,
    required this.myStory,
  });

  final List<StoryModel> stories;
  final bool myStory;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          StoryView(
              storyItems: di<StoriesCubit>().storyItems,
              controller: di<StoriesCubit>().storyController!,
              onStoryShow: (storyItem, index) {
                di<StoriesCubit>().changeStoryIndex(index: index);
                final storyModel = stories[index];
                if (!storyModel.viewersPhones!
                        .contains(di<UserStorage>().getUser()!.phone) &&
                    di<StoriesCubit>().contactStoryModel != null &&
                    !myStory) {
                  di<StoriesCubit>().viewContactStory(storyModel: storyModel);
                }

                debugPrint("index=========>${di<StoriesCubit>().storyIndex}");

                debugPrint(
                    "index=========>${di<StoriesCubit>().storyItems.length}");
              },
              onComplete: () {
                debugPrint("COMPLETED");
                Go.back(context: context);
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Go.back(context: context);
                }
              }),
          if (myStory)
            MyStoryViewers(
                viewers: di<StoriesCubit>()
                    .myStories[di<StoriesCubit>().storyIndex]
                    .viewers!)
          else
            const ReplyToStory(),
          // ,
        ],
      ),
    );
  }
}
