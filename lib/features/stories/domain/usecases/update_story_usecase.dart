import 'package:dartz/dartz.dart';
import 'package:nuntius_/core/base_usecase/base_usecase.dart';
import 'package:nuntius_/core/errors/failures.dart';
import 'package:nuntius_/features/stories/domain/parameters/update_story_params.dart';
import 'package:nuntius_/features/stories/domain/repositories/stories_repository.dart';

class UpdateStoryUsecase implements BaseUseCase<void, UpdateStoryParams> {
  final StoriesRepository storiesRepository;

  UpdateStoryUsecase({required this.storiesRepository});

  @override
  Future<Either<Failure, void>> call(UpdateStoryParams updateStoryParams) {
    return storiesRepository.updateStory(updateStoryParams: updateStoryParams);
  }
}
