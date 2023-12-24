// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message_model.dart';

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
