import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/presentation/widgets/delete_stories/text_story_inside_circle.dart';
import 'package:flutter/material.dart';

class StoryContent extends StatelessWidget {
  final StoryModel storyModel;
  final String? videoThumbnail;
  const StoryContent(
      {super.key, required this.storyModel, required this.videoThumbnail});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.s27,
      backgroundColor: AppColors.lightBlack,
      backgroundImage: _imageStoryInsideCircle(
        storyModel: storyModel,
        videoThumbnail: videoThumbnail,
      ),
      child: _storyInsideCircle(
        storyModel: storyModel,
        videoThumbnail: videoThumbnail,
      ),
    );
  }
}

StatelessWidget? _storyInsideCircle(
    {required StoryModel storyModel, required String? videoThumbnail}) {
  return storyModel.isImage == true
      ? null
      : storyModel.isVideo == true
          ? videoThumbnail == null
              ? CustomCircleIndicator(
                  size: AppSize.s18,
                  strokeWidth: 1,
                )
              : null
          : TextStoryInsideCircle(
              text: storyModel.text!,
            );
}

ImageProvider<Object>? _imageStoryInsideCircle(
    {required StoryModel storyModel, required String? videoThumbnail}) {
  return storyModel.isImage == true
      ? CachedNetworkImageProvider(storyModel.media!)
      : storyModel.isVideo == true
          ? videoThumbnail != null
              ? FileImage(File(videoThumbnail)) as ImageProvider
              : null
          : null;
}
