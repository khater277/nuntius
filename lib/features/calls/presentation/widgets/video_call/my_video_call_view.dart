import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:flutter/material.dart';

class MyVideoCallView extends StatelessWidget {
  const MyVideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidth.w5)
            .add(EdgeInsets.only(top: AppHeight.h20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s20),
          child: Container(
            width: AppWidth.w150,
            height: AppHeight.h180,
            color: AppColors.lightBlack,
            child: BlocBuilder<CallsCubit, CallsState>(
              buildWhen: (previous, current) => current.maybeWhen(
                myVideoViewCreated: () => true,
                orElse: () => false,
              ),
              builder: (context, state) {
                return state.maybeWhen(
                  myVideoViewCreated: () => AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: di<CallsCubit>().agoraEngine!,
                      canvas: VideoCanvas(uid: di<CallsCubit>().uid),
                    ),
                  ),
                  orElse: () => Center(
                    child: CustomCircleIndicator(
                      size: AppSize.s25,
                      strokeWidth: 1,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
