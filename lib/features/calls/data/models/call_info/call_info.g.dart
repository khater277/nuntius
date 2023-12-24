// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_info.dart';

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
