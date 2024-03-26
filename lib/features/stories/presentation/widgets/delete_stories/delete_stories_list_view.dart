import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/widgets/delete_stories/delete_stories_item.dart';

class DeleteStoriesListView extends StatelessWidget {
  const DeleteStoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: di<StoriesCubit>().myStories.length,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: AppHeight.h8),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidth.w8),
        child:
            DeleteStoriesItem(storyModel: di<StoriesCubit>().myStories[index]),
      ),
    );
  }
}
