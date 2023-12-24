import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius_/features/stories/presentation/widgets/story_view/story_view_body.dart';
import 'package:nuntius_/features/stories/presentation/widgets/story_view/story_view_head.dart';

class StoryViewScreen extends StatefulWidget {
  final List<StoryModel> stories;
  final UserData user;
  const StoryViewScreen({super.key, required this.stories, required this.user});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late StoriesCubit storiesCubit;
  @override
  void initState() {
    storiesCubit = StoriesCubit.get(context);
    storiesCubit.initStoryView(
      context: context,
      stories: widget.stories,
    );
    super.initState();
  }

  @override
  void dispose() {
    storiesCubit.disposeStoryView();
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
        final cubit = StoriesCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StoryViewHead(
                    stories: widget.stories, user: widget.user, cubit: cubit),
                StoryViewBody(
                  cubit: cubit,
                  stories: widget.stories,
                  myStory: widget.user.uId == di<UserStorage>().getData()!.uId,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
