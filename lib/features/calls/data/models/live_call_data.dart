import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';

class LiveCallData {
  final CallType callType;
  final String userToken;
  final String rtcToken;
  final String channelName;
  final String image;
  final String name;
  final String phoneNumber;
  final bool receiveCall;
  final DateTime? receiveCallEndDate;

  LiveCallData({
    required this.callType,
    required this.userToken,
    required this.rtcToken,
    required this.channelName,
    required this.image,
    required this.name,
    required this.phoneNumber,
    required this.receiveCall,
    this.receiveCallEndDate,
  });
}
