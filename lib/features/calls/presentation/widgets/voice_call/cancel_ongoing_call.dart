import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/presentation/widgets/control_call_buttons/control_call_button.dart';

class CancelOngoingCall extends StatelessWidget {
  const CancelOngoingCall({
    super.key,
    required this.userToken,
  });
  final String userToken;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      builder: (context, state) => ControlCallButton(
        icon: Icons.call_end,
        onPressed: () {
          state.maybeWhen(
            cancelCallLoading: () => () {},
            orElse: () {
              // if (!di<CallsCubit>().isJoined) {
              //   Go.back(context: context);
              // } else {
              di<CallsCubit>().pushCallNotification(
                notificationType: NotificationType.cancelCall,
                userToken: userToken,
              );
              di<CallsCubit>().cancelCall();
              // }
              // return null;
            },
          );
        },
        backgroundColor: AppColors.red,
        loadingCondition: state.maybeWhen(
          cancelCallLoading: () => true,
          orElse: () => false,
        ),
      ),
    );
  }
}
