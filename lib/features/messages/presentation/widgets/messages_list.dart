import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/presentation/widgets/day_date.dart';
import 'package:nuntius/features/messages/presentation/widgets/download_doc_button.dart';
import 'package:nuntius/features/messages/presentation/widgets/message_bubble/message_bubble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        getMessagesLoading: () => true,
        getMessages: (messages) => true,
        getMessagesError: (errorMsg) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.maybeWhen(
          getMessagesLoading: () =>
              const Center(child: CustomCircleIndicator()),
          orElse: () => Expanded(
            child: ListView.separated(
              controller: di<MessagesCubit>().scrollController!,
              reverse: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: di<MessagesCubit>().chat!.messages!.length,
              itemBuilder: (BuildContext context, int index) {
                final message = di<MessagesCubit>().chat!.messages![index];
                final isMyMessage =
                    message.senderId == di<UserStorage>().getUser()!.uId;
                return Column(
                  children: [
                    if (index ==
                            di<MessagesCubit>().chat!.messages!.length - 1 ||
                        DateFormat.yMMMEd().format(
                              DateTime.parse(message.date!),
                            ) !=
                            DateFormat.yMMMEd().format(
                              DateTime.parse(di<MessagesCubit>()
                                  .chat!
                                  .messages![index + 1]
                                  .date!),
                            ))
                      DayDate(date: message.date!),
                    Row(
                      mainAxisAlignment: isMyMessage
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        if (message.isDoc == true && !isMyMessage)
                          DownloadDocButton(
                            url: message.media!,
                            messageId: message.messageId!,
                            docName: message.message!,
                          ),
                        MessageBubble(
                          message: message,
                          isLastMessage: index ==
                              di<MessagesCubit>().chat!.messages!.length - 1,
                          isMyMessage: di<MessagesCubit>()
                                  .chat!
                                  .messages![index]
                                  .senderId ==
                              di<UserStorage>().getUser()!.uId,
                        ),
                        if (message.isDoc == true && isMyMessage)
                          DownloadDocButton(
                            url: message.media!,
                            messageId: message.messageId!,
                            docName: message.message!,
                          ),
                      ],
                    ),
                    if (0 == index) SizedBox(height: AppHeight.h5),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: AppHeight.h6,
              ),
            ),
          ),
        );
      },
    );
  }
}
