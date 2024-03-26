import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/chats/presentation/widgets/chat_last_message/deleted_last_message.dart';
import 'package:nuntius/features/chats/presentation/widgets/chat_last_message/media_last_message.dart';
import 'package:nuntius/features/chats/presentation/widgets/chat_last_message/text_last_message.dart';
import 'package:flutter/material.dart';

class ChatLastMessage extends StatelessWidget {
  final MessageType messageType;
  final String message;
  final bool isMyMessage;
  final bool isRead;

  const ChatLastMessage({
    super.key,
    required this.messageType,
    required this.message,
    required this.isMyMessage,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isMyMessage)
          SecondaryText(
            text: 'you : ',
            size: FontSize.s12,
          ),
        Expanded(
          child: messageType == MessageType.deleted
              ? const DeletedLastMessage()
              : messageType == MessageType.video
                  ? const MediaLastMessage(
                      icon: IconBroken.Video, name: 'video')
                  : messageType == MessageType.image
                      ? const MediaLastMessage(
                          icon: IconBroken.Image, name: 'image')
                      : messageType == MessageType.doc
                          ? const MediaLastMessage(
                              icon: IconBroken.Document, name: 'document')
                          : TextLastMessage(message: message),
        ),
        if (!isRead)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidth.w2),
            child: CircleAvatar(
              radius: AppSize.s3,
              backgroundColor: AppColors.blue,
            ),
          )
      ],
    );
  }
}
