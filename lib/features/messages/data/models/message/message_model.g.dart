// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 4;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      senderId: fields[0] as String?,
      receiverId: fields[1] as String?,
      message: fields[2] as String?,
      messageId: fields[3] as String?,
      date: fields[4] as String?,
      isDeleted: fields[5] as bool?,
      media: fields[6] as String?,
      isImage: fields[7] as bool?,
      isVideo: fields[8] as bool?,
      isDoc: fields[9] as bool?,
      isStoryReply: fields[10] as bool?,
      storyText: fields[11] as String?,
      storyMedia: fields[12] as String?,
      storyDate: fields[13] as String?,
      isStoryImageReply: fields[14] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.senderId)
      ..writeByte(1)
      ..write(obj.receiverId)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.messageId)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.isDeleted)
      ..writeByte(6)
      ..write(obj.media)
      ..writeByte(7)
      ..write(obj.isImage)
      ..writeByte(8)
      ..write(obj.isVideo)
      ..writeByte(9)
      ..write(obj.isDoc)
      ..writeByte(10)
      ..write(obj.isStoryReply)
      ..writeByte(11)
      ..write(obj.storyText)
      ..writeByte(12)
      ..write(obj.storyMedia)
      ..writeByte(13)
      ..write(obj.storyDate)
      ..writeByte(14)
      ..write(obj.isStoryImageReply);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      message: json['message'] as String?,
      messageId: json['messageId'] as String?,
      date: json['date'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      media: json['media'] as String?,
      isImage: json['isImage'] as bool?,
      isVideo: json['isVideo'] as bool?,
      isDoc: json['isDoc'] as bool?,
      isStoryReply: json['isStoryReply'] as bool?,
      storyText: json['storyText'] as String?,
      storyMedia: json['storyMedia'] as String?,
      storyDate: json['storyDate'] as String?,
      isStoryImageReply: json['isStoryImageReply'] as bool?,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'messageId': instance.messageId,
      'date': instance.date,
      'isDeleted': instance.isDeleted,
      'media': instance.media,
      'isImage': instance.isImage,
      'isVideo': instance.isVideo,
      'isDoc': instance.isDoc,
      'isStoryReply': instance.isStoryReply,
      'storyText': instance.storyText,
      'storyMedia': instance.storyMedia,
      'storyDate': instance.storyDate,
      'isStoryImageReply': instance.isStoryImageReply,
    };
