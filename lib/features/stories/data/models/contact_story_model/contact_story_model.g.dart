// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactStoryModelImpl _$$ContactStoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactStoryModelImpl(
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      stories: (json['stories'] as List<dynamic>?)
          ?.map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastStoryModel: json['lastStoryModel'] == null
          ? null
          : StoryModel.fromJson(json['lastStoryModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ContactStoryModelImplToJson(
        _$ContactStoryModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'stories': instance.stories,
      'lastStoryModel': instance.lastStoryModel,
    };
