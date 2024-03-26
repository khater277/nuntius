import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/back_button.dart';
import 'package:nuntius/core/shared_widgets/no_items_founded.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/widgets/delete_stories/delete_stories_list_view.dart';

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
      body: BlocBuilder<StoriesCubit, StoriesState>(
        buildWhen: (previous, current) => current.maybeWhen(
          getMyStories: (myStories) => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          if (di<StoriesCubit>().myStories.isEmpty) {
            return const NoItemsFounded(
              text: "There is no stories yet.",
              icon: IconBroken.Camera,
            );
          } else {
            return const DeleteStoriesListView();
          }
        },
      ),
    );
  }
}
