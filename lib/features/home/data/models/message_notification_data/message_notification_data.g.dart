// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageNotificationDataImpl _$$MessageNotificationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageNotificationDataImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      senderId: json['senderId'] as String?,
      type: json['type'] as String?,
      clickAction: json['click_action'] as String?,
    );

Map<String, dynamic> _$$MessageNotificationDataImplToJson(
        _$MessageNotificationDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'senderId': instance.senderId,
      'type': instance.type,
      'click_action': instance.clickAction,
    };
