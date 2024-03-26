// Future<Either<Failure, void>> updateProfileData(
//       {required Map<String, dynamic> data});

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/edit_profile/domain/repositories/edit_profile_repository.dart';

class UpdateProfileDataUsecase
    implements BaseUseCase<void, Map<String, dynamic>> {
  final EditProfileRepository editProfileRepository;

  UpdateProfileDataUsecase({required this.editProfileRepository});
  @override
  Future<Either<Failure, void>> call(Map<String, dynamic> data) {
    return editProfileRepository.updateProfileData(data: data);
  }
}
