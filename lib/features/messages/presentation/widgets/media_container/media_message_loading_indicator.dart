import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';

class MediaMessageLoadingIndicator extends StatelessWidget {
  const MediaMessageLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        sendMessageLoading: (percentage) => true,
        orElse: () => false,
      ),
      builder: (context, state) => state.maybeWhen(
        sendMessageLoading: (percentage) => Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppHeight.h1, horizontal: AppWidth.w4),
          child: LinearProgressIndicator(
            minHeight: 2.5,
            backgroundColor: AppColors.grey.withOpacity(0.2),
            color: AppColors.blue,
            value: percentage,
          ),
        ),
        orElse: () => const SizedBox(),
      ),
    );
  }
}
