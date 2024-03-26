// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_sounds.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/data/models/live_call_data.dart';
import 'package:nuntius/features/calls/presentation/widgets/receive_call/accept_button.dart';
import 'package:nuntius/features/calls/presentation/widgets/receive_call/cancel_button.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/call_profile_image.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/call_status_text.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ReceiveCallScreen extends StatefulWidget {
  final LiveCallData liveCallData;
  const ReceiveCallScreen({super.key, required this.liveCallData});

  @override
  State<ReceiveCallScreen> createState() => _ReceiveCallScreenState();
}

class _ReceiveCallScreenState extends State<ReceiveCallScreen> {
  final incomingCallPlayer = AudioPlayer();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await incomingCallPlayer.setAsset(AppSounds.incomingCall);
      await incomingCallPlayer.setLoopMode(LoopMode.all);
      await incomingCallPlayer.play();
    });
    final duration =
        widget.liveCallData.receiveCallEndDate!.difference(DateTime.now());

    Future.delayed(duration).then((value) {
      if (mounted) {
        Go.back(context: context);
      }
    });
    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    incomingCallPlayer.stop();
    incomingCallPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallsCubit, CallsState>(
      listener: (context, state) {
        state.maybeWhen(
          onLeaveChannel: (callId) => Go.back(context: context),
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
                    CallProfileImage(image: widget.liveCallData.image),
                    SizedBox(height: AppHeight.h20),
                    LargeHeadText(
                      text: widget.liveCallData.name,
                      size: FontSize.s16,
                    ),
                    SizedBox(height: AppHeight.h4),
                    const CallStatusText(text: "calling...."),
                    SizedBox(height: AppHeight.h50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CancelButton(
                          callType: widget.liveCallData.callType,
                          userToken: widget.liveCallData.userToken,
                        ),
                        AcceptButton(
                          liveCallData: widget.liveCallData,
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
