import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';

class SelectMediaButton extends StatelessWidget {
  final MessageType messageType;
  const SelectMediaButton({
    super.key,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        sendMessageLoading: (percentage) => true,
        sendMessage: () => true,
        sendMessageError: (errorMsg) => true,
        pickMediaMessage: (messageType) => true,
        closeMediaContainer: () => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w2),
          child: GestureDetector(
            onTap: () => state.maybeWhen(
              sendMessageLoading: (percentage) => null,
              orElse: () => di<MessagesCubit>()
                  .pickMediaMessage(messageType: messageType),
            ),
            child: Icon(
              messageType == MessageType.image
                  ? IconBroken.Image
                  : messageType == MessageType.video
                      ? IconBroken.Video
                      : IconBroken.Folder,
              size: AppSize.s20,
              color: AppColors.blue.withOpacity(0.8),
            ),
          ),
        );
      },
    );
  }
}
