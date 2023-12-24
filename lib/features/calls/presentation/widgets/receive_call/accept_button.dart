import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/calls/presentation/screens/video_call_screen.dart';
import 'package:nuntius_/features/calls/presentation/screens/voice_call_screen.dart';
import 'package:flutter/material.dart';

class AcceptButton extends StatelessWidget {
  final CallType callType;
  final String rtcToken;
  final String userToken;
  final String channelName;
  final String image;
  final String name;
  final String phoneNumber;
  const AcceptButton({
    super.key,
    required this.callType,
    required this.userToken,
    required this.rtcToken,
    required this.channelName,
    required this.image,
    required this.name,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: "accept",
          onPressed: () => callType == CallType.voice
              ? Go.off(
                  context: context,
                  screen: VoiceCallScreen(
                    rtcToken: rtcToken,
                    userToken: userToken,
                    channelName: channelName,
                    image: image,
                    name: name,
                    phoneNumber: phoneNumber,
                    receiveCall: true,
                  ),
                )
              : Go.off(
                  context: context,
                  screen: VideoCallScreen(
                    rtcToken: rtcToken,
                    userToken: userToken,
                    channelName: channelName,
                    image: image,
                    name: name,
                    phoneNumber: phoneNumber,
                    receiveCall: true,
                  ),
                ),
          backgroundColor: Colors.green,
          child: Icon(
            callType == CallType.voice ? IconBroken.Call : IconBroken.Video,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: AppHeight.h1,
        ),
        const SecondaryText(text: "accept"),
      ],
    );
  }
}
