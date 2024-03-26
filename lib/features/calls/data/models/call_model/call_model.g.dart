// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallModelAdapter extends TypeAdapter<CallModel> {
  @override
  final int typeId = 5;

  @override
  CallModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallModel(
      callId: fields[0] as String?,
      phoneNumber: fields[1] as String?,
      callType: fields[2] as CallType?,
      callStatus: fields[3] as CallStatus?,
      dateTime: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CallModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.callId)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.callType)
      ..writeByte(3)
      ..write(obj.callStatus)
      ..writeByte(4)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
