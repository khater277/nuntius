//   Future<Either<Failure, void>> updateLastStory(
//       {required StoryModel storyModel});
//   Future<Either<Failure, void>> deleteLastStory();
//   Future<Either<Failure, void>> updateStory(
//       {required StoryModel storyModel, required String phoneNumber});

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/stories/data/models/contact_story_model/contact_story_model.dart';
import 'package:nuntius/features/stories/domain/repositories/stories_repository.dart';

class GetContactsCurrentStoriesUsecase
    implements BaseUseCase<List<ContactStoryModel>?, List<UserData>> {
  final StoriesRepository storiesRepository;

  GetContactsCurrentStoriesUsecase({required this.storiesRepository});

  @override
  Future<Either<Failure, List<ContactStoryModel>?>> call(List<UserData> users) {
    return storiesRepository.getContactsCurrentStories(users: users);
  }
}
