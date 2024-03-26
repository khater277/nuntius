import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/auth/domain/repository/auth_repository.dart';

class GetAllUsersFromFirestoreUsecase
    implements BaseUseCase<List<UserData>, NoParams> {
  final AuthRepository authRepository;

  GetAllUsersFromFirestoreUsecase({required this.authRepository});

  @override
  Future<Either<Failure, List<UserData>>> call(NoParams params) {
    return authRepository.getAllUsersFromFirestore();
  }
}
