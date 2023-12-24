import 'package:dartz/dartz.dart';
import 'package:nuntius_/core/base_usecase/base_usecase.dart';
import 'package:nuntius_/core/errors/failures.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/auth/domain/repository/auth_repository.dart';

class AddUserToFirestoreUsecase implements BaseUseCase<void, UserData> {
  final AuthRepository authRepository;

  AddUserToFirestoreUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(UserData user) {
    return authRepository.addUserToFirestore(user: user);
  }
}
