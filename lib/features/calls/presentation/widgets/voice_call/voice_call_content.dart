import 'package:flutter/material.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/calls/presentation/widgets/call_status.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/call_profile_image.dart';

class VoiceCallContent extends StatelessWidget {
  final String image;
  final String name;
  final bool receiveCall;
  const VoiceCallContent({
    super.key,
    required this.image,
    required this.name,
    required this.receiveCall,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CallProfileImage(image: image),
        SizedBox(height: AppHeight.h25),
        LargeHeadText(
          text: name,
          size: FontSize.s16,
        ),
        SizedBox(height: AppHeight.h4),
        CallStatus(receiveCall: receiveCall)
      ],
    );
  }
}
