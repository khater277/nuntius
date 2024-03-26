import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/calls/data/models/call_info/call_info.dart';
import 'package:nuntius/features/calls/presentation/widgets/calls/call_name_and_caption.dart';
import 'package:nuntius/features/calls/presentation/widgets/calls/call_status_icon.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/user_image.dart';
import 'package:flutter/material.dart';

class CallsItems extends StatelessWidget {
  const CallsItems({
    super.key,
    required this.calls,
  });

  final List<CallInfo> calls;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: calls.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.symmetric(vertical: AppHeight.h15),
        child: Row(
          children: [
            UserImage(
              image: calls[index].image!,
              isCalls: true,
            ),
            SizedBox(width: AppWidth.w5),
            CallsNameAndCaption(
              callType: calls[index].callModel!.callType!,
              callStatus: calls[index].callModel!.callStatus!,
              name: calls[index].name!,
              date: calls[index].callModel!.dateTime!,
            ),
            CallStatusIcon(callStatus: calls[index].callModel!.callStatus!),
          ],
        ),
      ),
    );
  }
}
