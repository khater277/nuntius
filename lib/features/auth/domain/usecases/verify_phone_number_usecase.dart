import 'package:dartz/dartz.dart';
import 'package:nuntius_/core/base_usecase/base_usecase.dart';
import 'package:nuntius_/core/errors/failures.dart';
import 'package:nuntius_/features/auth/domain/parameters/verify_phone_number_params.dart';
import 'package:nuntius_/features/auth/domain/repository/auth_repository.dart';

class VerifyPhoneNumberUsecase
    implements BaseUseCase<void, VerifyPhoneNumberParams> {
  final AuthRepository authRepository;

  VerifyPhoneNumberUsecase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(
      VerifyPhoneNumberParams verifyPhoneNumberParams) {
    return authRepository.verifyPhoneNumber(
        verifyPhoneNumberParams: verifyPhoneNumberParams);
  }
}
