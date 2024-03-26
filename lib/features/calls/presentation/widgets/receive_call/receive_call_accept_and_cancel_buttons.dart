// import 'package:nuntius/core/utils/app_enums.dart';
// import 'package:nuntius/features/calls/presentation/widgets/receive_call/accept_button.dart';
// import 'package:nuntius/features/calls/presentation/widgets/receive_call/cancel_button.dart';
// import 'package:flutter/material.dart';

// class ReceiveCallAcceptAndCancelButtons extends StatelessWidget {
//   final CallType callType;
//   final String rtcToken;
//   final String userToken;
//   final String channelName;
//   final String image;
//   final String name;
//   final String phoneNumber;
//   const ReceiveCallAcceptAndCancelButtons({
//     super.key,
//     required this.callType,
//     required this.rtcToken,
//     required this.userToken,
//     required this.channelName,
//     required this.image,
//     required this.name,
//     required this.phoneNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         CancelButton(
//           callType: callType,
//           userToken: userToken,
//         ),
//         AcceptButton(
//             callType: callType,
//             rtcToken: rtcToken,
//             channelName: channelName,
//             image: image,
//             name: name,
//             phoneNumber: phoneNumber),
//       ],
//     );
//   }
// }
