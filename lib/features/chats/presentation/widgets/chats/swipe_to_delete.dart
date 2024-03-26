import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

ActionPane swipeToDelete({
  required BuildContext context,
  double? rightPadding,
  double? leftPadding,
}) {
  return ActionPane(
    dismissible: DismissiblePane(onDismissed: () {
      print("ASD");
    }),
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
        onPressed: (value) {
          // AppCubit.get(context).deleteChat(chatID: chatID);
        },
        backgroundColor: const Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: IconBroken.Delete,
        label: 'Delete',
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ],
  );
}
