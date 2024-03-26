import 'package:flutter/material.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/features/chats/data/models/chats_model.dart';
import 'package:nuntius/features/chats/presentation/widgets/chats/chat_builder.dart';

class ChatsItems extends StatelessWidget {
  final List<ChatsModel> chats;
  const ChatsItems({
    super.key,
    required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ChatBuilder(
                    user: chats[index].user!,
                    lastMessage: chats[index].lastMessage!,
                  ),
              separatorBuilder: (context, index) => Divider(
                    color: AppColors.grey.withOpacity(0.08),
                  ),
              itemCount: chats.length),
        )
      ],
    );
  }
}
