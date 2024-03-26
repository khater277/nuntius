import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/shared_widgets/text_form_field.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/presentation/widgets/media_container/media_container.dart';
import 'package:nuntius/features/messages/presentation/widgets/message_text_field/message_text_field_suffix_widget.dart';
import 'package:nuntius/features/messages/presentation/widgets/send_message_button.dart';

class SendMessageTextField extends StatelessWidget {
  const SendMessageTextField({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: di<MessagesCubit>().messageController!,
      builder: (BuildContext context, value, Widget? child) {
        return BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: AppHeight.h4,
                right: AppWidth.w4,
                left: AppWidth.w4,
              ),
              child: di<MessagesCubit>().user != null
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const MediaContainer(),
                              CustomTextField(
                                hintText: 'enter your message',
                                controller:
                                    di<MessagesCubit>().messageController!,
                                inputType: TextInputType.text,
                                suffixIcon: value.text.isEmpty
                                    ? const MessageTextFieldSuffixWidget()
                                    : null,
                                readOnly: di<MessagesCubit>().file != null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: AppWidth.w5),
                        SendMessageButton(value: value),
                      ],
                    )
                  : SmallHeadText(
                      text:
                          "this account has been deleted, you can'y message it right now.",
                      size: FontSize.s13,
                      color: AppColors.grey,
                      italic: true,
                      maxLines: 2,
                      center: true,
                    ),
            );
          },
        );
      },
    );
  }
}
