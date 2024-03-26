import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';
import 'package:nuntius/features/messages/presentation/widgets/message_bubble/reply_story_message/message_text_and_time.dart';
import 'package:nuntius/features/messages/presentation/widgets/message_bubble/reply_story_message/story_image.dart';
import 'package:nuntius/features/messages/presentation/widgets/message_bubble/reply_story_message/story_user_name_and_text.dart';

class StoryReplyMessage extends StatelessWidget {
  final MessageModel messageModel;
  const StoryReplyMessage({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.lightBlack.withOpacity(0.7),
              borderRadius: BorderRadius.circular(AppSize.s5)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppHeight.h6, horizontal: AppHeight.h8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StoryUserNameAndText(
                  name:
                      messageModel.senderId == di<UserStorage>().getUser()!.uId
                          ? "${di<MessagesCubit>().user!.name}'s"
                          : "My",
                  text: messageModel.storyText ?? "empty",
                  storyType: messageModel.storyMedia!.isEmpty
                      ? MessageType.text
                      : messageModel.isStoryImageReply == true
                          ? MessageType.image
                          : MessageType.video,
                ),
                SizedBox(width: AppWidth.w8),
                // LargeHeadText(text: messageModel.media!),
                if (messageModel.storyMedia!.isNotEmpty)
                  StoryImage(
                    media: messageModel.storyMedia!,
                    mediaType: messageModel.isStoryImageReply == true
                        ? MessageType.image
                        : MessageType.video,
                    messageId: messageModel.messageId!,
                  )
              ],
            ),
          ),
        ),
        SizedBox(height: AppHeight.h2),
        MessageTextAndTime(message: messageModel.message!),
      ],
    );
  }
}
