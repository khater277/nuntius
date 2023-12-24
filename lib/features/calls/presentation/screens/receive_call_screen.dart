// ignore_for_file: empty_catches

import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_sounds.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius_/features/calls/presentation/widgets/receive_call/accept_button.dart';
import 'package:nuntius_/features/calls/presentation/widgets/receive_call/cancel_button.dart';
import 'package:nuntius_/features/calls/presentation/widgets/voice_call/call_profile_image.dart';
import 'package:nuntius_/features/calls/presentation/widgets/voice_call/call_status_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class ReceiveCallScreen extends StatefulWidget {
  final String userToken;
  final String rtcToken;
  final String channelName;
  final String image;
  final String name;
  final String phoneNumber;
  final CallType callType;
  const ReceiveCallScreen({
    super.key,
    required this.userToken,
    required this.rtcToken,
    required this.channelName,
    required this.image,
    required this.name,
    required this.phoneNumber,
    required this.callType,
  });

  @override
  State<ReceiveCallScreen> createState() => _ReceiveCallScreenState();
}

class _ReceiveCallScreenState extends State<ReceiveCallScreen> {
  final incomingCallPlayer = AudioPlayer();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await incomingCallPlayer.setAsset(AppSounds.incomingCall);
      incomingCallPlayer.setLoopMode(LoopMode.all);
      incomingCallPlayer.play();
      Future.delayed(const Duration(seconds: 30)).then((value) {
        if (mounted) {
          incomingCallPlayer.stop();
          Go.back(context: context);
        }
      });
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
    incomingCallPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallsCubit, CallsState>(
      listener: (context, state) {
        state.maybeWhen(
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
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(AppSize.s20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CallProfileImage(image: widget.image),
                    SizedBox(height: AppHeight.h20),
                    LargeHeadText(
                      text: widget.name,
                      size: FontSize.s16,
                    ),
                    SizedBox(height: AppHeight.h4),
                    const CallStatusText(text: "calling...."),
                    SizedBox(height: AppHeight.h50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CancelButton(
                          callType: widget.callType,
                          userToken: widget.userToken,
                        ),
                        AcceptButton(
                          callType: widget.callType,
                          rtcToken: widget.rtcToken,
                          userToken: widget.userToken,
                          channelName: widget.channelName,
                          image: widget.image,
                          name: widget.name,
                          phoneNumber: widget.phoneNumber,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
