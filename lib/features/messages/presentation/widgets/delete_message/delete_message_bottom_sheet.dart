import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/presentation/widgets/delete_message/delete_message_widget.dart';
import 'package:flutter/material.dart';

class DeleteMessageBottomSheet extends StatelessWidget {
  final String messageId;
  const DeleteMessageBottomSheet({super.key, required this.messageId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w4),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s10),
              topRight: Radius.circular(AppSize.s10),
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppHeight.h18,
            horizontal: AppWidth.w10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DeleteMessageWidget(messageId: messageId),
            ],
          ),
        ),
      ),
    );
  }
}
