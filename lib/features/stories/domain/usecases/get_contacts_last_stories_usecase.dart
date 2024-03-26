//   Future<Either<Failure, List<ContactStoryModel>?>> getContactsCurrentStories(
//       {required List<UserData> users});
//   Future<Either<Failure, void>> updateLastStory(
//       {required StoryModel storyModel});
//   Future<Either<Failure, void>> deleteLastStory();
//   Future<Either<Failure, void>> updateStory(
//       {required StoryModel storyModel, required String phoneNumber});

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/stories/domain/repositories/stories_repository.dart';

class GetContactsLastStoriesUsecase
    implements
        BaseUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>, NoParams> {
  final StoriesRepository storiesRepository;

  GetContactsLastStoriesUsecase({required this.storiesRepository});

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      NoParams params) {
    return storiesRepository.getContactsLastStories();
  }
}
