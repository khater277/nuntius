import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class StoryModel with _$StoryModel {
  factory StoryModel({
    String? id,
    String? date,
    bool? isImage,
    bool? isRead,
    bool? isVideo,
    String? videoDuration,
    String? media,
    String? phone,
    String? text,
    List<Map<String, dynamic>>? viewers,
    List<String>? viewersPhones,
    List<String>? canView,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
