import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/shared_widgets/sliver_scrollable_view.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/presentation/screens/add_media_story_screen.dart';
import 'package:nuntius_/features/stories/presentation/widgets/stories/my_story/my_story.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  void initState() {
    di<StoriesCubit>().getMyStories();
    // StoriesCubit.get(context).contactsStoriesChanged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StoriesCubit, StoriesState>(
        listener: (context, state) {
          state.maybeWhen(
            // getContactsCurrentStoriesError: (errorMsg) =>
            //     errorSnackBar(context: context, errorMsg: errorMsg),
            pickStoryMediaLoading: (type) => Go.to(
                context: context,
                screen: AddMediaStoryScreen(messageType: type)),

            // pickStoryVideo: () => Go.to(
            //     context: context,
            //     screen:
            //         const AddMediaStoryScreen(messageType: MessageType.video)),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            getMyStoriesLoading: () =>
                const Center(child: CustomCircleIndicator()),
            getMyStoriesError: (errorMsg) => Center(
              child: LargeHeadText(
                text: errorMsg,
                maxLines: 10,
              ),
            ),
            orElse: () => SliverScrollableView(
                isScrollable: di<StoriesCubit>().contactsStories.isNotEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: AppHeight.h8),
                    const MyStory(),
                    // SizedBox(height: AppHeight.h5),
                    // Divider(color: AppColors.grey.withOpacity(0.3)),
                    // SizedBox(height: AppHeight.h5),
                    // state.maybeWhen(
                    //   getContactsCurrentStoriesLoading: () =>
                    //       const Center(child: CustomCircleIndicator()),
                    //   orElse: () => ContactCurrentStories(cubit: cubit),
                    // ),
                  ],
                )),
          );
        },
      ),
    );
    // return BlocConsumer<StoriesCubit, StoriesState>(
    //   listener: (context, state) {
    //     state.maybeWhen(
    //       getContactsCurrentStoriesError: (errorMsg) =>
    //           errorSnackBar(context: context, errorMsg: errorMsg),
    // pickStoryImage: () => Go.to(
    //     context: context,
    //     screen:
    //         const AddMediaStoryScreen(messageType: MessageType.image)),
    //       pickStoryVideo: () => Go.to(
    //           context: context,
    //           screen:
    //               const AddMediaStoryScreen(messageType: MessageType.video)),
    //       orElse: () {},
    //     );
    //   },
    //   builder: (context, state) {
    //     final cubit = StoriesCubit.get(context);
    //     return state.maybeWhen(
    //         pickStoryMediaLoading: () =>
    //             const Center(child: CustomCircleIndicator()),
    //         getMyStoriesLoading: () =>
    //             const Center(child: CustomCircleIndicator()),
    //         getContactsCurrentStoriesLoading: () =>
    //             const Center(child: CustomCircleIndicator()),
    //         orElse: () => SliverScrollableView(
    //             isScrollable: cubit.viewedStories.isNotEmpty ||
    //                 cubit.recentStories.isNotEmpty,
    // child: Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     SizedBox(height: AppHeight.h5),
    //     MyStory(cubit: cubit),
    //     SizedBox(height: AppHeight.h5),
    //     Divider(color: AppColors.grey.withOpacity(0.3)),
    //     SizedBox(height: AppHeight.h5),
    //     state.maybeWhen(
    //       getContactsCurrentStoriesLoading: () =>
    //           const Center(child: CustomCircleIndicator()),
    //       orElse: () => ContactCurrentStories(cubit: cubit),
    //     ),
    //   ],
    // )));
    //   },
    // );
  }
}
