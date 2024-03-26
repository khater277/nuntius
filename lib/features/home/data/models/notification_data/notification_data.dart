// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

@freezed
class NotificationData with _$NotificationData {
  factory NotificationData({
    required NotificationType type,
    required String notificationId,
    required String notificationDate,
    required String phoneNumber,
    required String senderID,
    String? userToken,
    String? senderName,
    String? callId,
    CallType? callType,
    String? token,
    String? channelName,
    @JsonKey(name: 'click_action') String? clickAction,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}
