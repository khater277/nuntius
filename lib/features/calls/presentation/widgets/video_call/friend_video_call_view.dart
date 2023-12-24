import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:nuntius_/features/calls/cubit/calls_cubit.dart';
import 'package:flutter/material.dart';

class FriendVideoCallView extends StatelessWidget {
  const FriendVideoCallView({super.key, required this.channelName});

  final String channelName;

  @override
  Widget build(BuildContext context) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: CallsCubit.get(context).agoraEngine!,
        canvas: VideoCanvas(uid: CallsCubit.get(context).remoteUid),
        connection: RtcConnection(channelId: channelName),
      ),
    );
  }
}
