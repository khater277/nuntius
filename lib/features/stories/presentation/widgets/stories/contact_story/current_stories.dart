import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/contact_story/contacts_stories_empty_view.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/contact_story/story_status.dart';

class ContactCurrentStories extends StatelessWidget {
  const ContactCurrentStories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesCubit, StoriesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        testSuccess: (myStories, contactStories, errorMsg) => true,
        getContactsCurrentStoriesLoading: () => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.maybeWhen(
            getContactsCurrentStoriesLoading: () => const Expanded(
                  child: Center(
                    child: CustomCircleIndicator(),
                  ),
                ),
            orElse: () => (di<StoriesCubit>().contactsStories.isEmpty)
                ? const ContactsStoriesEmptyView()
                : Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                        if (di<StoriesCubit>().recentStories.isNotEmpty)
                          StoryStatus(
                            contactStories: di<StoriesCubit>().recentStories,
                            isViewed: false,
                          ),
                        if (di<StoriesCubit>().viewedStories.isNotEmpty)
                          StoryStatus(
                            contactStories: di<StoriesCubit>().viewedStories,
                            isViewed: true,
                          ),
                      ],
                    ),
                  ));
      },
    );
    // if (cubit.recentStories.isEmpty && cubit.viewedStories.isEmpty) {
    //   return const Expanded(
    //     child: NoItemsFounded(
    //       text: "There is no stories to show yet.",
    //       icon: IconBroken.Camera,
    //     ),
    //   );
    // } else {
    //   return Flexible(
    //     fit: FlexFit.loose,
    //     child: Column(
    //       children: [
    // if (cubit.recentStories.isNotEmpty)
    //           StoryStatus(
    // contactStories: cubit.recentStories,
    // isViewed: false,
    //           ),
    //         if (cubit.viewedStories.isNotEmpty)
    //           Column(
    //             children: [
    //               StoryStatus(
    //                 contactStories: cubit.viewedStories,
    //                 isViewed: true,
    //               ),
    //             ],
    //           ),
    //       ],
    //     ),
    //   );
    // }
  }
}
