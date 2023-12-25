//   Future<Either<Failure, void>> updateStory(
//       {required StoryModel storyModel, required String phoneNumber});

import 'package:dartz/dartz.dart';
import 'package:nuntius_/core/base_usecase/base_usecase.dart';
import 'package:nuntius_/core/errors/failures.dart';
import 'package:nuntius_/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius_/features/stories/domain/repositories/stories_repository.dart';

class DeleteLastStoryUsecase implements BaseUseCase<void, NoParams> {
  final StoriesRepository storiesRepository;

  DeleteLastStoryUsecase({required this.storiesRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return storiesRepository.deleteLastStory();
  }
}
