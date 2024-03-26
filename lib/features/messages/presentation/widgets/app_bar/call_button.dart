import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';

class CallButton extends StatelessWidget {
  final CallType callType;

  const CallButton({super.key, required this.callType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        generateTokenLoading: (callType) => true,
        generateToken: (token, channelName, callType) => true,
        generateTokenError: (errorMsg) => true,
        getUser: (user) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            if (di<MessagesCubit>().user!.inCall == true) {
              showSnackBar(
                context: context,
                message:
                    "${di<MessagesCubit>().user!.name!} in another call now.",
                color: AppColors.lightBlack,
              );
            } else if (di<MessagesCubit>().user == null) {
              showSnackBar(
                context: context,
                message: "You can't start a call with deleted account..",
                color: AppColors.lightBlack,
              );
            } else {
              di<MessagesCubit>().generateToken(callType: callType);
            }
          },
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
