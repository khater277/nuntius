import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius_/features/messages/presentation/widgets/day_date.dart';
import 'package:nuntius_/features/messages/presentation/widgets/message_bubble/message_bubble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        getMessages: (messages) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            controller: di<MessagesCubit>().scrollController!,
            reverse: true,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: di<MessagesCubit>().messages.length,
            itemBuilder: (BuildContext context, int index) => Column(
              children: [
                if (index == di<MessagesCubit>().messages.length - 1 ||
                    DateFormat.yMMMEd().format(
                          DateTime.parse(
                              di<MessagesCubit>().messages[index].date!),
                        ) !=
                        DateFormat.yMMMEd().format(
                          DateTime.parse(
                              di<MessagesCubit>().messages[index + 1].date!),
                        ))
                  DayDate(date: di<MessagesCubit>().messages[index].date!),
                Row(
                  children: [
                    Flexible(
                      child: MessageBubble(
                        message: di<MessagesCubit>().messages[index],
                        isLastMessage:
                            index == di<MessagesCubit>().messages.length - 1,
                        loadingCondition: state ==
                            MessagesState.deleteMessageLoading(
                                di<MessagesCubit>().messages[index].messageId!),
                        isMyMessage:
                            di<MessagesCubit>().messages[index].senderId ==
                                di<UserStorage>().getData()!.uId,
                      ),
                    ),
                    if (state ==
                        MessagesState.openDocMessageLoading(
                            di<MessagesCubit>().messages[index].messageId!))
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
                        child: CustomCircleIndicator(
                          size: AppSize.s18,
                          strokeWidth: AppSize.s1,
                        ),
                      ),
                  ],
                ),
                if (0 == index) SizedBox(height: AppHeight.h5),
              ],
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: AppHeight.h6,
            ),
          ),
        );
      },
    );
  }
}
