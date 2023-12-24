// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_data.freezed.dart';
part 'call_data.g.dart';

@freezed
class CallData with _$CallData {
  factory CallData({
    String? type,
    String? callType,
    String? callId,
    String? token,
    String? userToken,
    String? channelName,
    @JsonKey(name: 'senderID') String? senderId,
    String? phoneNumber,
    @JsonKey(name: 'click_action') String? clickAction,
  }) = _CallData;

  factory CallData.fromJson(Map<String, dynamic> json) =>
      _$CallDataFromJson(json);
}
