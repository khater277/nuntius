import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/core/shared_widgets/back_button.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/presentation/widgets/app_bar/call_button.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const MessagesAppBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppHeight.h60,
      backgroundColor: AppColors.darkBlack,
      surfaceTintColor: AppColors.darkBlack,
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(AppSize.s20),
        bottomRight: Radius.circular(AppSize.s20),
      )),
      title: BlocBuilder<MessagesCubit, MessagesState>(
        buildWhen: (previous, current) => current.maybeWhen(
          getUser: (user) => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          return LargeHeadText(
            text: name,
            size: FontSize.s15,
          );
        },
      ),
      leading: const CustomBackButton(),
      actions: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
            child: const Row(
              children: [
                CallButton(callType: CallType.voice),
                CallButton(callType: CallType.video),
              ],
            ))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppHeight.h60);
}
