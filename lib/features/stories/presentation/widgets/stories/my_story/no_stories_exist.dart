import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class NoStoriesExist extends StatelessWidget {
  final String? image;

  const NoStoriesExist({
    super.key,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Align(
          alignment: AlignmentDirectional.center,
          child: CircleAvatar(
            radius: AppSize.s21,
            backgroundColor: AppColors.blue.withOpacity(0.2),
            backgroundImage:
                image == null ? null : CachedNetworkImageProvider("$image"),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppHeight.h1, horizontal: AppWidth.w1),
          child: CircleAvatar(
            radius: AppSize.s8,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: CircleAvatar(
                radius: AppSize.s6,
                backgroundColor: AppColors.blue.withOpacity(0.7),
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: AppSize.s10,
                )),
          ),
        ),
      ],
    );
  }
}
