import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/presentation/screens/delete_stories_screen.dart';
import 'package:flutter/material.dart';

class EditMyStories extends StatelessWidget {
  const EditMyStories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          Go.to(context: context, screen: const DeleteStoriesScreen()),
      icon: Icon(
        IconBroken.Setting,
        color: AppColors.blue,
        size: AppSize.s16,
      ),
    );
  }
}
