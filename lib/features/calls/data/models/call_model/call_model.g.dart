// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallModelImpl _$$CallModelImplFromJson(Map<String, dynamic> json) =>
    _$CallModelImpl(
      callId: json['callId'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      callType: $enumDecodeNullable(_$CallTypeEnumMap, json['callType']),
      callStatus: $enumDecodeNullable(_$CallStatusEnumMap, json['callStatus']),
      dateTime: json['dateTime'] as String?,
    );

Map<String, dynamic> _$$CallModelImplToJson(_$CallModelImpl instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'phoneNumber': instance.phoneNumber,
      'callType': _$CallTypeEnumMap[instance.callType],
      'callStatus': _$CallStatusEnumMap[instance.callStatus],
      'dateTime': instance.dateTime,
    };

const _$CallTypeEnumMap = {
  CallType.voice: 'voice',
  CallType.video: 'video',
};

const _$CallStatusEnumMap = {
  CallStatus.inComing: 'inComing',
  CallStatus.outComing: 'outComing',
  CallStatus.inComingNoResponse: 'inComingNoResponse',
  CallStatus.outComingNoResponse: 'outComingNoResponse',
};
