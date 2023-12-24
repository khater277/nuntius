import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/shared_widgets/no_items_founded.dart';
import 'package:nuntius_/core/shared_widgets/sliver_scrollable_view.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/chats/cubit/chats_cubit.dart';
import 'package:nuntius_/features/chats/presentation/widgets/chats/chat_items.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  // @override
  // void initState() {
  //   ChatsCubit.get(context).getChats(context);
  //   ChatsCubit.get(context).initChats(users: HomeCubit.get(context).users);

  //   super.initState();
  // }

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
              isScrollable: di<ChatsCubit>().users.isNotEmpty,
              child: Center(
                child: di<ChatsCubit>().users.isEmpty
                    ? const NoItemsFounded(
                        text:
                            "no chats founded , start now new chats with your friends.",
                        icon: IconBroken.Chat,
                      )
                    : ChatsItems(
                        users: di<ChatsCubit>().users,
                        lastMessages: di<ChatsCubit>().lastMessages,
                      ),
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
