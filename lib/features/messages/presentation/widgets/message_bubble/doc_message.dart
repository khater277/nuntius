import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';

class DocMessage extends StatelessWidget {
  const DocMessage({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => di<MessagesCubit>().openDocMessage(
        messageId: message.messageId!,
        docName: message.message!,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconBroken.Document,
            color: AppColors.white,
            size: AppSize.s20,
          ),
          SizedBox(width: AppWidth.w6),
          Flexible(
            fit: FlexFit.loose,
            child: SmallHeadText(
              text: message.message!,
              size: FontSize.s13,
              maxLines: 1000000,
              isUnderLine: true,
              center: true,
            ),
          ),
          SizedBox(width: AppWidth.w5),
          SecondaryText(
            text:
                DateFormat.jm().format(DateTime.parse(message.date!).toLocal()),
            color: AppColors.grey,
            size: FontSize.s10,
          )
        ],
      ),
    );
  }
}
