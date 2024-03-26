import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/presentation/widgets/control_call_buttons/control_call_button.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      buildWhen: (previous, current) => current.maybeWhen(
        toggleMute: (value) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return ControlCallButton(
          icon: di<CallsCubit>().mute ? Icons.mic_off : Icons.mic,
          onPressed: () => di<CallsCubit>().toggleMute(),
          backgroundColor: AppColors.lightBlack,
        );
      },
    );
  }
}
