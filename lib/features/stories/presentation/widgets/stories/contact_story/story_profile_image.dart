import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';

import 'package:flutter/material.dart';

class StoryProfileImage extends StatelessWidget {
  final String image;
  final bool isViewed;

  const StoryProfileImage({
    super.key,
    required this.image,
    required this.isViewed,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.s25,
      backgroundColor: isViewed ? Colors.grey.withOpacity(0.7) : AppColors.blue,
      child: CircleAvatar(
        radius: AppSize.s24,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: CircleAvatar(
          radius: AppSize.s24,
          backgroundColor: image == ""
              ? AppColors.lightBlack
              : AppColors.blue.withOpacity(0.2),
          backgroundImage:
              image != "" ? CachedNetworkImageProvider(image) : null,
          child: image == ""
              ? const Icon(
                  IconBroken.Profile,
                  color: AppColors.blue,
                )
              : null,
        ),
      ),
    );
    //}
  }
}
