// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDataImpl _$$NotificationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationDataImpl(
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      notificationId: json['notificationId'] as String,
      notificationDate: json['notificationDate'] as String,
      phoneNumber: json['phoneNumber'] as String,
      senderID: json['senderID'] as String,
      userToken: json['userToken'] as String?,
      senderName: json['senderName'] as String?,
      callId: json['callId'] as String?,
      callType: $enumDecodeNullable(_$CallTypeEnumMap, json['callType']),
      token: json['token'] as String?,
      channelName: json['channelName'] as String?,
      clickAction: json['click_action'] as String?,
    );

Map<String, dynamic> _$$NotificationDataImplToJson(
        _$NotificationDataImpl instance) =>
    <String, dynamic>{
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'notificationId': instance.notificationId,
      'notificationDate': instance.notificationDate,
      'phoneNumber': instance.phoneNumber,
      'senderID': instance.senderID,
      'userToken': instance.userToken,
      'senderName': instance.senderName,
      'callId': instance.callId,
      'callType': _$CallTypeEnumMap[instance.callType],
      'token': instance.token,
      'channelName': instance.channelName,
      'click_action': instance.clickAction,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.message: 'message',
  NotificationType.receiveCall: 'receiveCall',
  NotificationType.cancelCall: 'cancelCall',
  NotificationType.joinCall: 'joinCall',
};

const _$CallTypeEnumMap = {
  CallType.voice: 'voice',
  CallType.video: 'video',
};
