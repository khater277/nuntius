import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';

class FriendVideoCallView extends StatelessWidget {
  const FriendVideoCallView({super.key, required this.channelName});

  final String channelName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      // buildWhen: (previous, current) => current.maybeWhen(
      //   friendVideoViewCreated: () => true,
      //   orElse: () => false,
      // ),
      builder: (context, state) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: di<CallsCubit>().agoraEngine!,
            canvas: VideoCanvas(uid: di<CallsCubit>().remoteUid),
            connection: RtcConnection(channelId: channelName),
          ),
        );
        // return state.maybeWhen(
        //   friendVideoViewCreated: () => AgoraVideoView(
        //     controller: VideoViewController.remote(
        //       rtcEngine: di<CallsCubit>().agoraEngine!,
        //       canvas: VideoCanvas(uid: di<CallsCubit>().remoteUid),
        //       connection: RtcConnection(channelId: channelName),
        //     ),
        //   ),
        //   orElse: () => Center(
        //     child: CustomCircleIndicator(
        //       size: AppSize.s30,
        //     ),
        //   ),
        // );
      },
    );
  }
}
