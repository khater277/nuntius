import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/back_button.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/presentation/widgets/delete_stories/delete_story_button.dart';
import 'package:nuntius_/features/stories/presentation/widgets/delete_stories/story_content.dart';
import 'package:nuntius_/features/stories/presentation/widgets/delete_stories/story_type_and_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteStoriesScreen extends StatefulWidget {
  const DeleteStoriesScreen({super.key});

  @override
  State<DeleteStoriesScreen> createState() => _DeleteStoriesScreenState();
}

class _DeleteStoriesScreenState extends State<DeleteStoriesScreen> {
  @override
  void initState() {
    di<StoriesCubit>().createVideosThumbnails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        titleSpacing: 0,
        title: const LargeHeadText(text: "My Stories"),
      ),
      body: BlocConsumer<StoriesCubit, StoriesState>(
        buildWhen: (previous, current) => current.maybeWhen(
          deleteStoryLoading: (storyId) => true,
          deleteStoryError: (errorMsg) => true,
          deleteStory: () => true,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.maybeWhen(
            deleteStoryError: (errorMsg) =>
                errorSnackBar(context: context, errorMsg: errorMsg),
            deleteStory: () {
              di<StoriesCubit>().cancelLoading();
              Go.back(context: context);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: di<StoriesCubit>().myStories.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: AppHeight.h8),
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w8),
              child: state.maybeWhen(
                deleteStoryLoading: (storyId) =>
                    storyId == di<StoriesCubit>().myStories[index].id
                        ? Center(
                            child: CustomCircleIndicator(
                              size: AppSize.s22,
                              strokeWidth: 1.2,
                            ),
                          )
                        : const SizedBox(),
                orElse: () => Row(
                  children: [
                    StoryContent(
                      storyModel: di<StoriesCubit>().myStories[index],
                      videoThumbnail: di<StoriesCubit>().videosThumbnails[
                          di<StoriesCubit>().myStories[index].id],
                    ),
                    SizedBox(width: AppWidth.w8),
                    StoryTypeAndTime(
                      date: di<StoriesCubit>().myStories[index].date!,
                      storyType: di<StoriesCubit>().myStories[index].isImage ==
                              true
                          ? MessageType.image
                          : di<StoriesCubit>().myStories[index].isVideo == true
                              ? MessageType.video
                              : MessageType.doc,
                    ),
                    const Spacer(),
                    DeleteStoryButton(
                        storyModel: di<StoriesCubit>().myStories[index])
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
