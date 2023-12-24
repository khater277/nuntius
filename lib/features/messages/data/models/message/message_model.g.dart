// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

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
