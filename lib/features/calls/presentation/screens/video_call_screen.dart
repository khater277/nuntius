// ignore_for_file: use_build_context_synchronously

import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_sounds.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius_/features/calls/presentation/widgets/video_call/friend_video_call_view.dart';
import 'package:nuntius_/features/calls/presentation/widgets/video_call/my_video_call_view.dart';
import 'package:nuntius_/features/calls/presentation/widgets/voice_call/call_profile_image.dart';
import 'package:nuntius_/features/calls/presentation/widgets/voice_call/call_status_text.dart';
import 'package:nuntius_/features/calls/presentation/widgets/voice_call/cancel_ongoing_call.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class VideoCallScreen extends StatefulWidget {
  final String userToken;
  final String rtcToken;
  final String channelName;
  final String image;
  final String name;
  final String phoneNumber;
  final bool receiveCall;
  const VideoCallScreen({
    super.key,
    required this.userToken,
    required this.rtcToken,
    required this.channelName,
    required this.image,
    required this.name,
    required this.phoneNumber,
    this.receiveCall = false,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late CallsCubit callsCubit;
  final connectingPlayer = AudioPlayer();
  final callingPlayer = AudioPlayer();

  @override
  void initState() {
    callsCubit = CallsCubit.get(context);
    callsCubit.setupAgoraSDKEngine(
      userToken: widget.userToken,
      rtcToken: widget.rtcToken,
      channelName: widget.channelName,
      friendPhoneNumber: widget.phoneNumber,
      callType: CallType.video,
      receiveCall: widget.receiveCall,
    );

    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await connectingPlayer.setAsset(AppSounds.connecting);
      await callingPlayer.setAsset(AppSounds.calling);
      if (!CallsCubit.get(context).isJoined) {
        connectingPlayer.setLoopMode(LoopMode.all);
        connectingPlayer.play();
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['type'] == 'cancel-call' &&
          message.data['phoneNumber'] == widget.phoneNumber) {
        if (mounted) {
          Go.back(context: context);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    callsCubit.leaveCall();
    connectingPlayer.dispose();
    callingPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallsCubit, CallsState>(
      listener: (context, state) {
        if (CallsCubit.get(context).remoteUid == null &&
            widget.receiveCall == false) {
          connectingPlayer.stop();
          callingPlayer.setLoopMode(LoopMode.all);
          callingPlayer.play();
          Future.delayed(const Duration(seconds: 30)).then((value) {
            callingPlayer.stop();
            if (mounted && CallsCubit.get(context).remoteUid == null) {
              Go.back(context: context);
            }
          });
        } else {
          connectingPlayer.stop();
          callingPlayer.stop();
        }
        state.maybeWhen(
          onUserOffline: () => Go.back(context: context),
          cancelCall: () => Go.back(context: context),
          cancelCallError: (errorMsg) => showSnackBar(
            context: context,
            message: errorMsg,
            color: AppColors.red,
          ),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final cubit = CallsCubit.get(context);
        return Scaffold(
          // appBar: AppBar(
          //   leading: const CustomBackButton(),
          // ),
          body: Stack(
            children: [
              if (!cubit.isJoined || cubit.remoteUid == null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CallProfileImage(image: widget.image),
                      SizedBox(height: AppHeight.h25),
                      LargeHeadText(
                        text: widget.name,
                        size: FontSize.s16,
                      ),
                      SizedBox(height: AppHeight.h4),
                      if (!cubit.isJoined)
                        const CallStatusText(text: "connecting....")
                      else if (cubit.remoteUid == null &&
                          widget.receiveCall == false)
                        const CallStatusText(text: "calling....")
                      else if (cubit.remoteUid == null &&
                          widget.receiveCall == true)
                        const CallStatusText(text: "connecting....")
                    ],
                  ),
                )
              else
                FriendVideoCallView(channelName: widget.channelName),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: EdgeInsets.only(top: AppHeight.h20),
                  child: const MyVideoCallView(),
                ),
              ),
            ],
          ),
          floatingActionButton: CancelOngoingCall(userToken: widget.userToken),
        );
      },
    );
  }
}
