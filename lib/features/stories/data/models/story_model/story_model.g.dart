// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryModelImpl _$$StoryModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryModelImpl(
      id: json['id'] as String?,
      date: json['date'] as String?,
      isImage: json['isImage'] as bool?,
      isRead: json['isRead'] as bool?,
      isVideo: json['isVideo'] as bool?,
      videoDuration: json['videoDuration'] as String?,
      media: json['media'] as String?,
      phone: json['phone'] as String?,
      text: json['text'] as String?,
      viewers: (json['viewers'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      viewersPhones: (json['viewersPhones'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      canView:
          (json['canView'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$StoryModelImplToJson(_$StoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'isImage': instance.isImage,
      'isRead': instance.isRead,
      'isVideo': instance.isVideo,
      'videoDuration': instance.videoDuration,
      'media': instance.media,
      'phone': instance.phone,
      'text': instance.text,
      'viewers': instance.viewers,
      'viewersPhones': instance.viewersPhones,
      'canView': instance.canView,
    };
