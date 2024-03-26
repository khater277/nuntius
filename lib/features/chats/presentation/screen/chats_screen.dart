import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/no_items_founded.dart';
import 'package:nuntius/core/shared_widgets/sliver_scrollable_view.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/chats/cubit/chats_cubit.dart';
import 'package:nuntius/features/chats/presentation/widgets/chats/chat_items.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatsCubit, ChatsState>(
        listener: (context, state) {
          state.maybeWhen(
            getChatsError: (errorMsg) =>
                errorSnackBar(context: context, errorMsg: errorMsg),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            getChatsLoading: () => const Center(child: CustomCircleIndicator()),
            orElse: () => SliverScrollableView(
              isScrollable: di<ChatsCubit>().chats.isNotEmpty,
              child: Center(
                child: di<ChatsCubit>().chats.isEmpty
                    ? const NoItemsFounded(
                        text:
                            "no chats founded , start now new chats with your friends.",
                        icon: IconBroken.Chat,
                      )
                    : ChatsItems(chats: di<ChatsCubit>().chats),
              ),
            ),
          );
        },
      ),
    );
    // return BlocConsumer<ChatsCubit, ChatsState>(
    //   listener: (context, state) {
    //     state.maybeWhen(
    //       getChatsError: (errorMsg) =>
    //           errorSnackBar(context: context, errorMsg: errorMsg),
    //       orElse: () {},
    //     );
    //   },
    //   builder: (context, state) {
    //     final ChatsCubit cubit = ChatsCubit.get(context);
    //     return state.maybeWhen(
    //       getChatsLoading: () => const Center(child: CustomCircleIndicator()),
    //       initChats: () => const Center(child: CustomCircleIndicator()),
    //       orElse: () => SliverScrollableView(
    //         isScrollable: cubit.users.isNotEmpty,
    //         child: cubit.users.isEmpty
    //             ? const NoItemsFounded(
    //                 text:
    //                     "no chats founded , start now new chats with your friends.",
    //                 icon: IconBroken.Chat,
    //               )
    //             : ChatsItems(
    //                 users: cubit.users,
    //                 lastMessages: cubit.lastMessages,
    //               ),
    //       ),
    //     );
    //   },
    // );
  }
}
