import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/screens/story_view_screen.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/my_story/add_my_story_profile_image.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/my_story/edit_my_stories.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/my_story/my_story_date.dart';

class MyStory extends StatelessWidget {
  const MyStory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesCubit, StoriesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        getMyStories: (myStories) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (di<StoriesCubit>().myStories.isNotEmpty) {
              Go.to(
                  context: context,
                  screen: StoryViewScreen(
                    stories: di<StoriesCubit>().myStories,
                    user: di<UserStorage>().getUser()!,
                  ));
            } else {
              di<StoriesCubit>().pickStoryMedia(type: MessageType.image);
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                AddMyStoryProfileImage(stories: di<StoriesCubit>().myStories),
                SizedBox(width: AppWidth.w10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeHeadText(
                      text: "My story",
                      size: FontSize.s14,
                    ),
                    SizedBox(height: AppHeight.h2),
                    di<StoriesCubit>().myStories.isNotEmpty
                        ? MyStoryDate(
                            date: di<StoriesCubit>().myStories.last.date!)
                        : SmallHeadText(
                            text: "tab to add stories update",
                            size: FontSize.s11,
                            color: AppColors.grey,
                          ),
                  ],
                ),
                const Spacer(),
                const EditMyStories(),
              ],
            ),
          ),
        );
      },
    );
  }
}
