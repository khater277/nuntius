import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/call_status_text.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/call_timer.dart';

class CallStatus extends StatelessWidget {
  final bool receiveCall;
  const CallStatus({super.key, required this.receiveCall});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      builder: (context, state) {
        if (!di<CallsCubit>().isJoined) {
          return const CallStatusText(text: "connecting....");
        } else if (di<CallsCubit>().remoteUid == null && receiveCall == false) {
          return const CallStatusText(text: "calling....");
        } else if (di<CallsCubit>().remoteUid == null && receiveCall == true) {
          return const CallStatusText(text: "connecting....");
        } else if (di<CallsCubit>().remoteUid == 0) {
          return const CallStatusText(text: "connecting....");
        } else {
          return const CallTimer();
        }
      },
    );
  }
}
