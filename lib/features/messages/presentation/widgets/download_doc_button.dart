import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';

class DownloadDocButton extends StatelessWidget {
  final String url;
  final String messageId;
  final String docName;
  const DownloadDocButton({
    super.key,
    required this.url,
    required this.messageId,
    required this.docName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
      child: BlocBuilder<MessagesCubit, MessagesState>(
        buildWhen: (previous, current) => current.maybeWhen(
          downloadDocMessageLoading: (messageId, percentage) =>
              this.messageId == messageId,
          downloadDocMessage: (messageId) => this.messageId == messageId,
          downloadDocMessageError: (messageId, errorMsg) =>
              this.messageId == messageId,
          // getMessages: (messages) => tru,
          orElse: () => false,
        ),
        builder: (context, state) {
          return state.maybeWhen(
            downloadDocMessageLoading: (messageId, percentage) =>
                CustomCircleIndicator(
              size: AppSize.s18,
              strokeWidth: AppSize.s1,
              percentage: percentage,
            ),
            orElse: () =>
                di<MessagesCubit>().docMessagesStatus[messageId] == false
                    ? GestureDetector(
                        onTap: () => di<MessagesCubit>().downloadDocMessage(
                          url: url,
                          messageId: messageId,
                          docName: docName,
                        ),
                        child: Icon(
                          Icons.download,
                          color: AppColors.blue,
                          size: AppSize.s18,
                        ),
                      )
                    : const SizedBox(),
          );
        },
      ),
    );
  }
}
