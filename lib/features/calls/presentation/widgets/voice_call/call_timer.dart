import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_functions.dart';
import 'package:flutter/material.dart';

class CallTimer extends StatefulWidget {
  const CallTimer({
    super.key,
  });

  @override
  State<CallTimer> createState() => _CallTimerState();
}

class _CallTimerState extends State<CallTimer> {
  final Stream stream = Stream.periodic(const Duration(seconds: 1), (a) => a);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return SecondaryText(
          text: AppFunctions.calculateCallTime(data: snapshot.data),
          isButton: true,
          size: FontSize.s13,
        );
      },
    );
  }
}
