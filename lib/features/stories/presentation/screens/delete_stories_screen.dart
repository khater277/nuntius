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
    StoriesCubit.get(context).createVideosThumbnails();
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
        listener: (context, state) {
          state.maybeWhen(
            deleteStoryError: (errorMsg) =>
                errorSnackBar(context: context, errorMsg: errorMsg),
            deleteStory: () {
              StoriesCubit.get(context).cancelLoading();
              Go.back(context: context);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final cubit = StoriesCubit.get(context);
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.myStories.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: AppHeight.h8),
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w8),
              child: state ==
                      StoriesState.deleteStoryLoading(
                          cubit.myStories[index].id!)
                  ? Center(
                      child: CustomCircleIndicator(
                        size: AppSize.s22,
                        strokeWidth: 1.2,
                      ),
                    )
                  : Row(
                      children: [
                        StoryContent(
                          storyModel: cubit.myStories[index],
                          videoThumbnail:
                              cubit.videosThumbnails[cubit.myStories[index].id],
                        ),
                        SizedBox(width: AppWidth.w8),
                        StoryTypeAndTime(
                          date: cubit.myStories[index].date!,
                          storyType: cubit.myStories[index].isImage == true
                              ? MessageType.image
                              : cubit.myStories[index].isVideo == true
                                  ? MessageType.video
                                  : MessageType.doc,
                        ),
                        const Spacer(),
                        DeleteStoryButton(storyModel: cubit.myStories[index])
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
