import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/calls/presentation/widgets/control_call_buttons/control_call_button.dart';

class CancelButton extends StatelessWidget {
  final CallType callType;
  final String userToken;
  const CancelButton(
      {super.key, required this.callType, required this.userToken});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CallsCubit, CallsState>(
          builder: (context, state) {
            return ControlCallButton(
              icon: IconBroken.Call_Missed,
              onPressed: state.maybeWhen(
                cancelCallLoading: () => () {},
                orElse: () => () {
                  di<CallsCubit>().pushCallNotification(
                    notificationType: NotificationType.cancelCall,
                    userToken: userToken,
                  );
                  di<CallsCubit>().cancelCall();
                },
              ),
              backgroundColor: Colors.red,
            );
          },
        ),
        SizedBox(height: AppHeight.h2),
        const SecondaryText(text: "cancel"),
      ],
    );
  }
}
