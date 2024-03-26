import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_story_model.freezed.dart';
part 'contact_story_model.g.dart';

@freezed
class ContactStoryModel with _$ContactStoryModel {
  factory ContactStoryModel({
    UserData? user,
    List<StoryModel>? stories,
    StoryModel? lastStoryModel,
  }) = _ContactStoryModel;

  factory ContactStoryModel.fromJson(Map<String, dynamic> json) =>
      _$ContactStoryModelFromJson(json);
}
