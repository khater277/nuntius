import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String image;
  final bool isChat;
  final bool isCalls;
  const UserImage({
    super.key,
    required this.image,
    this.isChat = false,
    this.isCalls = false,
  });

  @override
  Widget build(BuildContext context) {
    if (image == "") {
      return SizedBox(
        width: isChat
            ? AppWidth.w40
            : isCalls
                ? AppWidth.w35
                : AppWidth.w30,
        child: Icon(
          IconBroken.Profile,
          size: isChat
              ? AppSize.s30
              : isCalls
                  ? AppSize.s25
                  : AppSize.s22,
          color: AppColors.blue,
        ),
      );
    } else {
      return SizedBox(
        width: isChat
            ? AppWidth.w45
            : isCalls
                ? AppWidth.w40
                : AppWidth.w30,
        child: CircleAvatar(
          radius: isChat ? AppSize.s28 : AppSize.s20,
          backgroundColor: AppColors.lightBlack,
          backgroundImage: CachedNetworkImageProvider(image),
        ),
      );
    }
  }
}
