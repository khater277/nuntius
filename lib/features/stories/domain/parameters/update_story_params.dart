import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';

class UpdateStoryParams {
  final StoryModel storyModel;
  final String phoneNumber;

  UpdateStoryParams({required this.storyModel, required this.phoneNumber});
}
