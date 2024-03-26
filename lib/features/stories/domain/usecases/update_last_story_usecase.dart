//   Future<Either<Failure, void>> deleteLastStory();
//   Future<Either<Failure, void>> updateStory(
//       {required StoryModel storyModel, required String phoneNumber});

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/domain/repositories/stories_repository.dart';

class UpdateLastStoryUsecase implements BaseUseCase<void, StoryModel> {
  final StoriesRepository storiesRepository;

  UpdateLastStoryUsecase({required this.storiesRepository});

  @override
  Future<Either<Failure, void>> call(StoryModel storyModel) {
    return storiesRepository.updateLastStory(storyModel: storyModel);
  }
}
