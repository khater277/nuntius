import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/shared_widgets/back_button.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius_/features/messages/presentation/widgets/app_bar/call_button.dart';
import 'package:flutter/material.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessagesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppHeight.h60,
      backgroundColor: AppColors.darkBlack,
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
            text: di<MessagesCubit>().user!.name!,
            size: FontSize.s15,
          );
        },
      ),
      leading: Builder(builder: (context) {
        // di<MessagesCubit>()
        //     .readMessage(lastMessages: ChatsCubit.get(context).lastMessages);
        return const CustomBackButton();
      }),
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
