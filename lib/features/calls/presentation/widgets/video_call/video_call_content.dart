import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/data/models/live_call_data.dart';
import 'package:nuntius/features/calls/presentation/widgets/video_call/friend_video_call_view.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/voice_call_content.dart';

class VideoCallContent extends StatelessWidget {
  final LiveCallData liveCallData;
  const VideoCallContent({super.key, required this.liveCallData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      builder: (context, state) {
        if (di<CallsCubit>().remoteUid == null ||
            di<CallsCubit>().remoteUid == 0) {
          return VoiceCallContent(
            image: liveCallData.image,
            name: liveCallData.name,
            receiveCall: liveCallData.receiveCall,
          );
        } else {
          return FriendVideoCallView(channelName: liveCallData.channelName);
        }
      },
    );
  }
}
