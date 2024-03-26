import 'package:nuntius/core/utils/app_images.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:nuntius/features/calls/data/models/call_status/call_status.dart';

class StatusIconData {
  final int quarter;
  final String icon;
  final Color iconColor;

  StatusIconData(
      {required this.quarter, required this.icon, required this.iconColor});
}

class CallStatusIcon extends StatelessWidget {
  final CallStatus callStatus;
  const CallStatusIcon({super.key, required this.callStatus});

  @override
  Widget build(BuildContext context) {
    late StatusIconData data;
    if (callStatus == CallStatus.outComing) {
      data = StatusIconData(
        quarter: 0,
        icon: AppImages.inbound,
        iconColor: Colors.green,
      );
    } else if (callStatus == CallStatus.inComing) {
      data = StatusIconData(
        quarter: 2,
        icon: AppImages.inbound,
        iconColor: Colors.green,
      );
    } else if (callStatus == CallStatus.inComingNoResponse) {
      data = StatusIconData(
        quarter: 0,
        icon: AppImages.missed,
        iconColor: Colors.red,
      );
    } else {
      data = StatusIconData(
        quarter: 2,
        icon: AppImages.missed,
        iconColor: Colors.red,
      );
    }

    return RotatedBox(
      quarterTurns: data.quarter,
      child: ImageIcon(
        AssetImage(data.icon),
        color: data.iconColor,
        size: AppSize.s12,
      ),
    );
  }
}
