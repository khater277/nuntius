import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/alert_dialog.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nuntius/features/chats/cubit/chats_cubit.dart';

ActionPane swipeToDelete({
  // required BuildContext context,
  required String name,
  required String phoneNumber,
  double? rightPadding,
  double? leftPadding,
}) {
  return ActionPane(
    dismissible: DismissiblePane(onDismissed: () {}),
    dragDismissible: false,
    motion: Padding(
      padding: EdgeInsets.only(
        right: rightPadding ?? 0,
        left: leftPadding ?? 0,
      ),
      child: const ScrollMotion(),
    ),
    children: [
      SlidableAction(
        onPressed: (context) {
          showAlertDialog(
            context: context,
            text: "Are you sure you want to delete $name's chat?",
            okPressed: () =>
                di<ChatsCubit>().deleteChat(phoneNumber: phoneNumber),
          );
        },
        backgroundColor: AppColors.lightBlack,
        foregroundColor: AppColors.blue,
        icon: IconBroken.Delete,

        // label: 'Delete',
        borderRadius: BorderRadius.circular(AppSize.s4),
      ),
    ],
  );
}
