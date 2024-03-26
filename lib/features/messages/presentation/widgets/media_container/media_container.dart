import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/presentation/widgets/media_container/close_media_container_button.dart';
import 'package:nuntius/features/messages/presentation/widgets/media_container/media_message_loading_indicator.dart';
import 'package:nuntius/features/messages/presentation/widgets/media_container/send_media_message_content.dart';

class MediaContainer extends StatefulWidget {
  const MediaContainer({
    super.key,
  });

  @override
  State<MediaContainer> createState() => _MediaContainerState();
}

class _MediaContainerState extends State<MediaContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        if (di<MessagesCubit>().file != null) {
          return Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: AppHeight.h2, horizontal: AppWidth.w1),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    ),
                    height: state ==
                            const MessagesState.pickMediaMessage(
                                MessageType.doc)
                        ? AppHeight.h100
                        : AppHeight.h150,
                    width: double.infinity,
                    child: Center(
                        child: BlocBuilder<MessagesCubit, MessagesState>(
                      builder: (context, state) => const Column(
                        children: [
                          SendMediaMessageContent(),
                          MediaMessageLoadingIndicator(),
                        ],
                      ),
                    )),
                  ),
                  const CloseMediaContainerButton(),
                ],
              ),
              SizedBox(height: AppHeight.h5),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
