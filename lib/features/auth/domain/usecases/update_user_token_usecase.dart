import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/repository/auth_repository.dart';

class UpdateUserTokenUsecase implements BaseUseCase<void, String> {
  final AuthRepository authRepository;

  UpdateUserTokenUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(String token) {
    return authRepository.updateUserToken(token: token);
  }
}
