import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/presentation/widgets/media_container/view_file.dart';
import 'package:nuntius/features/messages/presentation/widgets/media_container/view_video.dart';

class SendMediaMessageContent extends StatelessWidget {
  const SendMediaMessageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        pickMediaMessageLoading: () => true,
        pickMediaMessage: (messageType) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return Expanded(
          child: state.maybeWhen(
            pickMediaMessage: (messageType) {
              if (messageType == MessageType.image) {
                return Image.file(di<MessagesCubit>().file!);
              } else if (messageType == MessageType.video) {
                return const ViewVideo();
              } else {
                return const ViewFile();
              }
            },
            orElse: () => const Center(child: CustomCircleIndicator()),
          ),
        );
      },
    );
  }
}
