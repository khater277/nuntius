import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/parameters/sign_in_with_phone_number_params.dart';
import 'package:nuntius/features/auth/domain/repository/auth_repository.dart';

class SignInWithPhoneNumberUsecase
    implements BaseUseCase<UserCredential, SignInWithPhoneNumberParams> {
  final AuthRepository authRepository;

  SignInWithPhoneNumberUsecase({required this.authRepository});
  @override
  Future<Either<Failure, UserCredential>> call(
      SignInWithPhoneNumberParams signInWithPhoneNumberParams) {
    return authRepository.signInWithPhoneNumber(
        signInWithPhoneNumberParams: signInWithPhoneNumberParams);
  }
}
