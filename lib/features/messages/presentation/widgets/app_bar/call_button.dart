import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallButton extends StatelessWidget {
  final CallType callType;

  const CallButton({super.key, required this.callType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () =>
              di<MessagesCubit>().generateToken(callType: callType),
          icon: state.maybeWhen(
            generateTokenLoading: (callType) {
              if (callType == this.callType) {
                return CustomCircleIndicator(size: AppSize.s17);
              } else {
                return Icon(
                  this.callType == CallType.video
                      ? IconBroken.Video
                      : IconBroken.Call,
                  color: AppColors.blue,
                  size: AppSize.s20,
                );
              }
            },
            orElse: () => Icon(
              callType == CallType.video ? IconBroken.Video : IconBroken.Call,
              color: AppColors.blue,
              size: AppSize.s20,
            ),
          ),
        );
      },
    );
  }
}
