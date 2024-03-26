//   Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
//       getContactsLastStories();
//   Future<Either<Failure, List<ContactStoryModel>?>> getContactsCurrentStories(
//       {required List<UserData> users});
//   Future<Either<Failure, void>> updateLastStory(
//       {required StoryModel storyModel});
//   Future<Either<Failure, void>> deleteLastStory();
//   Future<Either<Failure, void>> updateStory(
//       {required StoryModel storyModel, required String phoneNumber});

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/stories/domain/repositories/stories_repository.dart';

class DeleteStoryUsecase implements BaseUseCase<void, String> {
  final StoriesRepository storiesRepository;

  DeleteStoryUsecase({required this.storiesRepository});

  @override
  Future<Either<Failure, void>> call(String storyId) {
    return storiesRepository.deleteStory(storyId: storyId);
  }
}
