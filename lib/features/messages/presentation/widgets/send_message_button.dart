import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';

class SendMessageButton extends StatefulWidget {
  final TextEditingValue value;
  const SendMessageButton({
    super.key,
    required this.value,
  });

  @override
  State<SendMessageButton> createState() => _SendMessageButtonState();
}

class _SendMessageButtonState extends State<SendMessageButton> {
  MessageType? _messageType;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        state.maybeWhen(
          sendMessageError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          pickMediaMessage: (messageType) => _messageType = messageType,
          orElse: () {},
        );
      },
      builder: (context, state) {
        return InkWell(
          onTap: state.maybeWhen(
            sendMessageLoading: (percentage) => null,
            orElse: () => () {
              if (widget.value.text.isNotEmpty) {
                di<MessagesCubit>().sendMessage();
              } else if (di<MessagesCubit>().file != null) {
                di<MessagesCubit>()
                    .sendMediaMessage(messageType: _messageType!);
              }
            },
          ),
          child: CircleAvatar(
            radius: AppSize.s22,
            backgroundColor:
                widget.value.text.isNotEmpty || di<MessagesCubit>().file != null
                    ? AppColors.blue
                    : Colors.grey,
            child: state.maybeWhen(
              sendMessageLoading: (percentage) => CustomCircleIndicator(
                size: AppSize.s16,
                color: AppColors.white,
                strokeWidth: 1,
                // percentage: percentage,
              ),
              orElse: () => Icon(
                IconBroken.Send,
                size: AppSize.s22,
                color: widget.value.text.isNotEmpty ||
                        di<MessagesCubit>().file != null
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
