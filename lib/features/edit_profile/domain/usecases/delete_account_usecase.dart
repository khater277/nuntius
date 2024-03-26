// Future<Either<Failure, void>> updateProfileData(
//       {required Map<String, dynamic> data});

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/edit_profile/domain/repositories/edit_profile_repository.dart';

class DeleteAccountUsecase implements BaseUseCase<void, NoParams> {
  final EditProfileRepository editProfileRepository;

  DeleteAccountUsecase({required this.editProfileRepository});
  @override
  Future<Either<Failure, void>> call(NoParams noParams) {
    return editProfileRepository.deleteAccount();
  }
}
