import 'package:nuntius_/core/shared_widgets/no_items_founded.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/presentation/widgets/stories/contact_story/story_status.dart';
import 'package:flutter/material.dart';

class ContactCurrentStories extends StatelessWidget {
  const ContactCurrentStories({
    super.key,
    required this.cubit,
  });

  final StoriesCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (cubit.recentStories.isEmpty && cubit.viewedStories.isEmpty) {
      return const Expanded(
        child: NoItemsFounded(
          text: "There is no stories to show yet.",
          icon: IconBroken.Camera,
        ),
      );
    } else {
      return Flexible(
        fit: FlexFit.loose,
        child: Column(
          children: [
            if (cubit.recentStories.isNotEmpty)
              StoryStatus(
                contactStories: cubit.recentStories,
                isViewed: false,
              ),
            if (cubit.viewedStories.isNotEmpty)
              Column(
                children: [
                  StoryStatus(
                    contactStories: cubit.viewedStories,
                    isViewed: true,
                  ),
                ],
              ),
          ],
        ),
      );
    }
  }
}
