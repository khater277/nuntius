import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/story_view_body.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/story_view_head.dart';

class StoryViewScreen extends StatefulWidget {
  final List<StoryModel> stories;
  final UserData user;
  const StoryViewScreen({super.key, required this.stories, required this.user});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  @override
  void initState() {
    di<StoriesCubit>().initStoryView(stories: widget.stories);
    super.initState();
  }

  @override
  void dispose() {
    di<StoriesCubit>().disposeStoryView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoriesCubit, StoriesState>(
      listener: (context, state) {
        state.maybeWhen(
          replyToStory: () => Go.back(context: context),
          replyToStoryError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<StoriesCubit, StoriesState>(
                  buildWhen: (previous, current) => current.maybeWhen(
                    changeStoryIndex: (index) => true,
                    orElse: () => false,
                  ),
                  builder: (context, state) {
                    return StoryViewHead(
                      storyDate:
                          widget.stories[di<StoriesCubit>().storyIndex].date!,
                      user: widget.user,
                    );
                  },
                ),
                StoryViewBody(
                  stories: widget.stories,
                  myStory: widget.user.uId == di<UserStorage>().getUser()!.uId,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
