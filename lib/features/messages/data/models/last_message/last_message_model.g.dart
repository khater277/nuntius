// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LastMessageModelAdapter extends TypeAdapter<LastMessageModel> {
  @override
  final int typeId = 3;

  @override
  LastMessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastMessageModel(
      token: fields[0] as String?,
      image: fields[1] as String?,
      senderID: fields[2] as String?,
      receiverID: fields[3] as String?,
      message: fields[4] as String?,
      date: fields[5] as String?,
      media: fields[6] as String?,
      isImage: fields[7] as bool?,
      isVideo: fields[8] as bool?,
      isDoc: fields[9] as bool?,
      isDeleted: fields[10] as bool?,
      isRead: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, LastMessageModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.senderID)
      ..writeByte(3)
      ..write(obj.receiverID)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.media)
      ..writeByte(7)
      ..write(obj.isImage)
      ..writeByte(8)
      ..write(obj.isVideo)
      ..writeByte(9)
      ..write(obj.isDoc)
      ..writeByte(10)
      ..write(obj.isDeleted)
      ..writeByte(11)
      ..write(obj.isRead);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastMessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LastMessageModelImpl _$$LastMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LastMessageModelImpl(
      token: json['token'] as String?,
      image: json['image'] as String?,
      senderID: json['senderID'] as String?,
      receiverID: json['receiverID'] as String?,
      message: json['message'] as String?,
      date: json['date'] as String?,
      media: json['media'] as String?,
      isImage: json['isImage'] as bool?,
      isVideo: json['isVideo'] as bool?,
      isDoc: json['isDoc'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$$LastMessageModelImplToJson(
        _$LastMessageModelImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'image': instance.image,
      'senderID': instance.senderID,
      'receiverID': instance.receiverID,
      'message': instance.message,
      'date': instance.date,
      'media': instance.media,
      'isImage': instance.isImage,
      'isVideo': instance.isVideo,
      'isDoc': instance.isDoc,
      'isDeleted': instance.isDeleted,
      'isRead': instance.isRead,
    };
