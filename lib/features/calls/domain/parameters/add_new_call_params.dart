import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';

class AddNewCallParams {
  final String friendPhoneNumber;
  final String callId;
  final CallType callType;

  AddNewCallParams({
    required this.friendPhoneNumber,
    required this.callId,
    required this.callType,
  });
}
