// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_notification_data.freezed.dart';
part 'message_notification_data.g.dart';

@freezed
class MessageNotificationData with _$MessageNotificationData {
  factory MessageNotificationData({
    String? id,
    String? name,
    String? phoneNumber,
    String? senderId,
    String? type,
    @JsonKey(name: 'click_action') String? clickAction,
  }) = _MessageNotificationData;

  factory MessageNotificationData.fromJson(Map<String, dynamic> json) =>
      _$MessageNotificationDataFromJson(json);
}
