import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/alert_dialog.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';

class DeleteMessageWidget extends StatelessWidget {
  final String messageId;
  const DeleteMessageWidget({super.key, required this.messageId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        state.maybeWhen(
          deleteMessage: () {
            Go.back(context: context);
            Go.back(context: context);
          },
          deleteMessageError: (errorMsg) {
            errorSnackBar(context: context, errorMsg: errorMsg);
            Go.back(context: context);
            Go.back(context: context);
          },
          orElse: () {},
        );
      },
      builder: (context, state) => GestureDetector(
        onTap: () => showAlertDialog(
          context: context,
          text: "Are you sure you want to delete this message?",
          okPressed: () =>
              di<MessagesCubit>().deleteMessage(messageId: messageId),
        ),
        child: Row(
          children: [
            const PrimaryText(
              text: "delete message",
              color: AppColors.grey,
            ),
            const Spacer(),
            Icon(
              IconBroken.Delete,
              color: AppColors.red,
              size: AppSize.s18,
            ),
            SizedBox(width: AppWidth.w5),
          ],
        ),
      ),
    );
  }
}
