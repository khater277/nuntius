import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/calls/cubit/calls_cubit.dart';
import 'package:flutter/material.dart';

class MyVideoCallView extends StatelessWidget {
  const MyVideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s20),
        child: Container(
          width: AppWidth.w150,
          height: AppHeight.h180,
          color: AppColors.lightBlack,
          child: AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: CallsCubit.get(context).agoraEngine!,
              canvas: VideoCanvas(uid: CallsCubit.get(context).uid),
            ),
          ),
        ),
      ),
    );
  }
}
