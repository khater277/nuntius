// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallNotificationDataImpl _$$CallNotificationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CallNotificationDataImpl(
      to: json['to'] as String?,
      priority: json['priority'] as String?,
      callData: json['data'] == null
          ? null
          : CallData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CallNotificationDataImplToJson(
        _$CallNotificationDataImpl instance) =>
    <String, dynamic>{
      'to': instance.to,
      'priority': instance.priority,
      'data': instance.callData,
    };
