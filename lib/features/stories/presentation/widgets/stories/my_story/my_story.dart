import 'package:flutter/material.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/presentation/screens/story_view_screen.dart';
import 'package:nuntius_/features/stories/presentation/widgets/stories/my_story/add_my_story_profile_image.dart';
import 'package:nuntius_/features/stories/presentation/widgets/stories/my_story/edit_my_stories.dart';
import 'package:nuntius_/features/stories/presentation/widgets/stories/my_story/my_story_date.dart';

class MyStory extends StatelessWidget {
  final StoriesCubit cubit;
  const MyStory({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cubit.myStories.isNotEmpty) {
          Go.to(
              context: context,
              screen: StoryViewScreen(
                stories: cubit.myStories,
                user: di<UserStorage>().getData()!,
              ));
        } else {
          cubit.pickStoryImage();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            AddMyStoryProfileImage(
              image: di<UserStorage>().getData()!.image,
              stories: cubit.myStories,
            ),
            SizedBox(width: AppWidth.w10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LargeHeadText(
                  text: "My story",
                  size: FontSize.s14,
                ),
                SizedBox(height: AppHeight.h2),
                cubit.myStories.isNotEmpty
                    ? MyStoryDate(date: cubit.myStories.last.date!)
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
  }
}
