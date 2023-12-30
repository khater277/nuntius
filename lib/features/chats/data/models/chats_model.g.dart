// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatsModelAdapter extends TypeAdapter<ChatsModel> {
  @override
  final int typeId = 2;

  @override
  ChatsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatsModel(
      user: fields[0] as UserData?,
      lastMessage: fields[1] as LastMessageModel?,
      messages: (fields[2] as List?)?.cast<MessageModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.lastMessage)
      ..writeByte(2)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatsModelImpl _$$ChatsModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatsModelImpl(
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] == null
          ? null
          : LastMessageModel.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatsModelImplToJson(_$ChatsModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'lastMessage': instance.lastMessage,
      'messages': instance.messages,
    };
