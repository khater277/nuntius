import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';

class StoryImage extends StatelessWidget {
  final MessageType mediaType;
  final String media;
  final String messageId;
  const StoryImage({
    super.key,
    required this.mediaType,
    required this.media,
    required this.messageId,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s5),
          child: SizedBox(
            width: AppSize.s40,
            height: AppSize.s40,
            child: mediaType == MessageType.image
                ? CachedNetworkImage(imageUrl: media)
                // : media.isEmpty || di<MessagesCubit>().videosThumbnails.isEmpty
                //     ? const SizedBox()
                : Image.file(
                    File(di<MessagesCubit>().videosThumbnails[messageId]!)),
          ),
        ),
      ),
    );
  }
}
