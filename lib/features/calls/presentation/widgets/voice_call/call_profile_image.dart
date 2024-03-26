import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';

import 'package:flutter/material.dart';

class CallProfileImage extends StatelessWidget {
  final String image;
  const CallProfileImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: AppColors.blue.withOpacity(0.15),
          blurRadius: 10,
          spreadRadius: AppSize.s15,
        ),
      ]),
      child: CircleAvatar(
        radius: AppSize.s50,
        backgroundColor: AppColors.lightBlack,
        backgroundImage:
            image.isNotEmpty ? CachedNetworkImageProvider(image) : null,
        child: image.isEmpty
            ? Icon(
                IconBroken.Profile,
                color: AppColors.blue,
                size: AppSize.s35,
              )
            : null,
      ),
    );
  }
}
