import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/stories/presentation/screens/delete_stories_screen.dart';
import 'package:flutter/material.dart';

class EditMyStories extends StatelessWidget {
  const EditMyStories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Go.to(context: context, screen: const DeleteStoriesScreen()),
      child: Icon(
        IconBroken.Setting,
        color: AppColors.blue,
        size: AppSize.s16,
      ),
    );
  }
}
