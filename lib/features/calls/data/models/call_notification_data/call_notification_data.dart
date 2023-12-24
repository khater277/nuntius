// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'call_data.dart';

part 'call_notification_data.freezed.dart';
part 'call_notification_data.g.dart';

@freezed
class CallNotificationData with _$CallNotificationData {
  factory CallNotificationData({
    String? to,
    String? priority,
    @JsonKey(name: 'data') CallData? callData,
  }) = _CallNotificationData;

  factory CallNotificationData.fromJson(Map<String, dynamic> json) =>
      _$CallNotificationDataFromJson(json);
}
