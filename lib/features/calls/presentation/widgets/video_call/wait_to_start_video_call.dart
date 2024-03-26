import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/call_profile_image.dart';
import 'package:nuntius/features/calls/presentation/widgets/voice_call/call_status_text.dart';
import 'package:flutter/material.dart';

class WaitToStartVideoCall extends StatelessWidget {
  const WaitToStartVideoCall({
    super.key,
    required this.name,
    required this.image,
    required this.receiveCall,
  });

  final String name;
  final String image;
  final bool receiveCall;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CallProfileImage(image: image),
          SizedBox(height: AppHeight.h25),
          LargeHeadText(
            text: name,
            size: FontSize.s16,
          ),
          SizedBox(height: AppHeight.h4),
          if (!di<CallsCubit>().isJoined)
            const CallStatusText(text: "connecting....")
          else if (di<CallsCubit>().remoteUid == null && receiveCall == false)
            const CallStatusText(text: "calling....")
          else if (di<CallsCubit>().remoteUid == null && receiveCall == true)
            const CallStatusText(text: "connecting....")
        ],
      ),
    );
  }
}
