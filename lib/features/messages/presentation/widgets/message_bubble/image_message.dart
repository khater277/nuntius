import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/network_image.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';
import 'package:nuntius/features/messages/presentation/screens/show_message_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    super.key,
    required this.isMyMessage,
    required this.message,
  });

  final bool isMyMessage;
  final MessageModel message;
  // final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Go.to(
          context: context,
          screen: ShowMessageImageScreen(
            imageUrl: message.media!,
            name: message.senderId == di<UserStorage>().getUser()!.uId
                ? "You"
                : di<MessagesCubit>().user!.name!,
            date: message.date!,
          )),
      child: SizedBox(
        width: AppWidth.w250,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(!isMyMessage ? AppSize.s20 : 0),
            topRight: Radius.circular(isMyMessage ? AppSize.s20 : 0),
            bottomLeft: Radius.circular(AppSize.s20),
            bottomRight: Radius.circular(AppSize.s20),
          ),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CustomNetworkImage(imageUrl: message.media!, fit: BoxFit.contain),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppHeight.h3, horizontal: AppWidth.w5),
                child: SecondaryText(
                  text: DateFormat.jm()
                      .format(DateTime.parse(message.date!).toLocal()),
                  color: AppColors.grey,
                  size: FontSize.s10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
