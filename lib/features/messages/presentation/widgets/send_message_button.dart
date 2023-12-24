import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';

class SendMessageButton extends StatelessWidget {
  final TextEditingValue value;
  const SendMessageButton({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        state.maybeWhen(
          sendMessageError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return InkWell(
          onTap: state.maybeWhen(
            sendMessageLoading: () => null,
            orElse: () => () {
              if (value.text.isNotEmpty) {
                di<MessagesCubit>().sendMessage();
              } else if (di<MessagesCubit>().file != null) {
                di<MessagesCubit>().sendMediaMessage();
              }
            },
          ),
          child: CircleAvatar(
            radius: AppSize.s22,
            backgroundColor:
                value.text.isNotEmpty || di<MessagesCubit>().file != null
                    ? AppColors.blue
                    : Colors.grey,
            child: state.maybeWhen(
              sendMessageLoading: () => CustomCircleIndicator(
                size: AppSize.s16,
                color: AppColors.white,
                strokeWidth: 1,
              ),
              orElse: () => Icon(
                IconBroken.Send,
                size: AppSize.s22,
                color: value.text.isNotEmpty || di<MessagesCubit>().file != null
                    ? Colors.white
                    : AppColors.lightBlack,
              ),
            ),
          ),
        );
      },
    );
  }
}
