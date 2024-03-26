import 'package:flutter/material.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/calls/data/models/live_call_data.dart';
import 'package:nuntius/features/calls/presentation/screens/live_call_screen.dart';
import 'package:nuntius/features/calls/presentation/widgets/control_call_buttons/control_call_button.dart';

class AcceptButton extends StatelessWidget {
  final LiveCallData liveCallData;
  const AcceptButton({super.key, required this.liveCallData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ControlCallButton(
          icon: liveCallData.callType == CallType.voice
              ? IconBroken.Call
              : IconBroken.Video,
          onPressed: () {
            Go.off(
              context: context,
              screen: LiveCallScreen(
                liveCallData: liveCallData,
              ),
            );
          },
          backgroundColor: Colors.green,
        ),
        SizedBox(
          height: AppHeight.h2,
        ),
        const SecondaryText(text: "accept"),
      ],
    );
  }
}
