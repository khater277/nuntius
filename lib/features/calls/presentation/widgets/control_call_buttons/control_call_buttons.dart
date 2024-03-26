import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/presentation/widgets/control_call_buttons/mute_button.dart';
import 'package:nuntius/features/calls/presentation/widgets/control_call_buttons/speaker_button.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/cancel_ongoing_call.dart';

class ControlCallButtons extends StatelessWidget {
  const ControlCallButtons({
    super.key,
    required this.userToken,
  });

  final String userToken;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      builder: (context, state) {
        return Align(
          alignment: di<CallsCubit>().isJoined == false
              ? AlignmentDirectional.bottomEnd
              : AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: AppHeight.h10,
              right: di<CallsCubit>().isJoined == false ? AppWidth.w10 : 0,
            ),
            child: di<CallsCubit>().isJoined == false
                ? CancelOngoingCall(userToken: userToken)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SpeakerButton(),
                      const MuteButton(),
                      CancelOngoingCall(userToken: userToken),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
