// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallInfoAdapter extends TypeAdapter<CallInfo> {
  @override
  final int typeId = 6;

  @override
  CallInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallInfo(
      callModel: fields[0] as CallModel?,
      name: fields[1] as String?,
      image: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CallInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.callModel)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallInfoImpl _$$CallInfoImplFromJson(Map<String, dynamic> json) =>
    _$CallInfoImpl(
      callModel: json['callModel'] == null
          ? null
          : CallModel.fromJson(json['callModel'] as Map<String, dynamic>),
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$CallInfoImplToJson(_$CallInfoImpl instance) =>
    <String, dynamic>{
      'callModel': instance.callModel,
      'name': instance.name,
      'image': instance.image,
    };
