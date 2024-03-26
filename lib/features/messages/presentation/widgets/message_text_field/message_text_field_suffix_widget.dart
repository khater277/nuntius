import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/presentation/widgets/message_text_field/select_media_button.dart';
import 'package:flutter/material.dart';

class MessageTextFieldSuffixWidget extends StatelessWidget {
  const MessageTextFieldSuffixWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppWidth.w4),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectMediaButton(messageType: MessageType.image),
          SelectMediaButton(messageType: MessageType.video),
          SelectMediaButton(messageType: MessageType.doc),
        ],
      ),
    );
  }
}
