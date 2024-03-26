import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/parameters/verify_phone_number_params.dart';
import 'package:nuntius/features/auth/domain/repository/auth_repository.dart';

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
