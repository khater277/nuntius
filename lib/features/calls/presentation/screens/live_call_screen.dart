// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_sounds.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/calls/data/models/live_call_data.dart';
import 'package:nuntius/features/calls/presentation/widgets/control_call_buttons/control_call_buttons.dart';
import 'package:nuntius/features/calls/presentation/widgets/video_call/my_video_call_view.dart';
import 'package:nuntius/features/calls/presentation/widgets/video_call/video_call_content.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/voice_call_content.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class LiveCallScreen extends StatefulWidget {
  final LiveCallData liveCallData;
  const LiveCallScreen({super.key, required this.liveCallData});

  @override
  State<LiveCallScreen> createState() => _LiveCallScreenState();
}

class _LiveCallScreenState extends State<LiveCallScreen> {
  final connectingPlayer = AudioPlayer();
  final callingPlayer = AudioPlayer();

  @override
  void initState() {
    di<CallsCubit>().setupAgoraSDKEngine(
      userToken: widget.liveCallData.userToken,
      rtcToken: widget.liveCallData.rtcToken,
      channelName: widget.liveCallData.channelName,
      friendPhoneNumber: widget.liveCallData.phoneNumber,
      callType: widget.liveCallData.callType,
      receiveCall: widget.liveCallData.receiveCall,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await connectingPlayer.setAsset(AppSounds.connecting);
      await connectingPlayer.setLoopMode(LoopMode.all);
      await connectingPlayer.play();

      await callingPlayer.setAsset(AppSounds.calling);
      await callingPlayer.setLoopMode(LoopMode.all);
    });
    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    callingPlayer.dispose();
    connectingPlayer.dispose();
    di<CallsCubit>().leaveCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallsCubit, CallsState>(
      listener: (context, state) {
        state.maybeWhen(
          onJoinChannelSuccess: () async {
            errorSnackBar(context: context, errorMsg: "errorMsg");
            await connectingPlayer.stop();
            if (di<CallsCubit>().remoteUid == null) {
              callingPlayer.play();
              Future.delayed(const Duration(seconds: 30)).then((value) async {
                if (di<CallsCubit>().remoteUid == null) {
                  await callingPlayer.stop();
                  if (context.mounted) {
                    Go.back(context: context);
                  }
                }
              });
            }
            if (widget.liveCallData.receiveCall) {
              await callingPlayer.stop();
            }
          },
          onUserJoined: (remoteUid) async {
            await callingPlayer.stop();
            // if (remoteUid == 0) {
            //   await connectingPlayer.play();
            // } else {
            //   await connectingPlayer.stop();
            // }
          },
          onLeaveChannel: (callId) => Go.back(context: context),
          orElse: () {},
        );
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.liveCallData.callType == CallType.voice)
                VoiceCallContent(
                  image: widget.liveCallData.image,
                  name: widget.liveCallData.name,
                  receiveCall: widget.liveCallData.receiveCall,
                )
              else
                VideoCallContent(liveCallData: widget.liveCallData),
              if (widget.liveCallData.callType == CallType.video)
                const MyVideoCallView(),
              ControlCallButtons(userToken: widget.liveCallData.userToken),
            ],
          ),
        ),
      ),
    );
  }
}
