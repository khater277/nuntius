import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/sliver_scrollable_view.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/screens/add_media_story_screen.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/contact_story/current_stories.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/my_story/my_story.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  void initState() {
    // di<StoriesCubit>().getMyStories();
    // di<StoriesCubit>().executeAsyncFunctions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoriesCubit, StoriesState>(
      listener: (context, state) {
        state.maybeWhen(
          pickStoryMediaLoading: (type) => Go.to(
              context: context, screen: AddMediaStoryScreen(messageType: type)),
          testSuccess: (myStories, contactStories, errorMsg) {
            if (errorMsg != null) {
              errorSnackBar(context: context, errorMsg: errorMsg);
              di<StoriesCubit>().showRefreshButton(refreshButton: true);
            } else {
              di<StoriesCubit>().showRefreshButton(refreshButton: false);
            }
          },
          testError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          orElse: () {},
        );
      },
      buildWhen: (previous, current) => current.maybeWhen(
        testLoading: () => true,
        testSuccess: (myStories, contactStories, errorMsg) => true,
        testError: (errorMsg) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        // final validStories = contactStory.stories!
        //         .where((element) => (DateTime.now()
        //                 .toUtc()
        //                 .difference(DateTime.parse(element.date!))
        //                 .inHours <
        //             24))
        //         .toList();
        return state.maybeWhen(
          testLoading: () => const Center(child: CustomCircleIndicator()),
          testError: (errorMsg) => LargeHeadText(
            text: errorMsg,
          ),
          orElse: () => SliverScrollableView(
            isScrollable: di<StoriesCubit>().contactsStories.isNotEmpty,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppHeight.h8),
                const MyStory(),
                SizedBox(height: AppHeight.h5),
                Divider(color: AppColors.grey.withOpacity(0.3)),
                SizedBox(height: AppHeight.h5),
                const ContactCurrentStories(),
                // state.maybeWhen(
                //   getContactsCurrentStoriesLoading: () =>
                //       const Center(child: CustomCircleIndicator()),
                //   orElse: () => ContactCurrentStories(cubit: cubit),
                // ),
              ],
            ),
          ),
        );
        // state.maybeWhen(
        //   getMyStoriesLoading: () =>
        //       const Center(child: CustomCircleIndicator()),
        // orElse: () => SliverScrollableView(
        //     isScrollable: di<StoriesCubit>().contactsStories.isNotEmpty,
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         SizedBox(height: AppHeight.h8),
        //         const MyStory(),
        //         SizedBox(height: AppHeight.h5),
        //         Divider(color: AppColors.grey.withOpacity(0.3)),
        //         SizedBox(height: AppHeight.h5),
        //         const ContactCurrentStories(),
        //         // state.maybeWhen(
        //         //   getContactsCurrentStoriesLoading: () =>
        //         //       const Center(child: CustomCircleIndicator()),
        //         //   orElse: () => ContactCurrentStories(cubit: cubit),
        //         // ),
        //       ],
        //     )),
        // );
      },
    );
  }
}
