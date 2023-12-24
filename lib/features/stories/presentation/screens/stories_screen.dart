import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:flutter/material.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  // @override
  // void initState() {
  //   StoriesCubit.get(context).getStories(context: context);
  //   StoriesCubit.get(context).contactsStoriesChanged();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LargeHeadText(text: "STORIES SCREEN")),
    );
    // return BlocConsumer<StoriesCubit, StoriesState>(
    //   listener: (context, state) {
    //     state.maybeWhen(
    //       getContactsCurrentStoriesError: (errorMsg) =>
    //           errorSnackBar(context: context, errorMsg: errorMsg),
    //       pickStoryImage: () => Go.to(
    //           context: context,
    //           screen:
    //               const AddMediaStoryScreen(messageType: MessageType.image)),
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
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 SizedBox(height: AppHeight.h5),
    //                 MyStory(cubit: cubit),
    //                 SizedBox(height: AppHeight.h5),
    //                 Divider(color: AppColors.grey.withOpacity(0.3)),
    //                 SizedBox(height: AppHeight.h5),
    //                 state.maybeWhen(
    //                   getContactsCurrentStoriesLoading: () =>
    //                       const Center(child: CustomCircleIndicator()),
    //                   orElse: () => ContactCurrentStories(cubit: cubit),
    //                 ),
    //               ],
    //             )));
    //   },
    // );
  }
}
