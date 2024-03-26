import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/auth/domain/parameters/sign_in_with_phone_number_params.dart';
import 'package:nuntius/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius/features/auth/domain/parameters/verify_phone_number_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> verifyPhoneNumber(
      {required VerifyPhoneNumberParams verifyPhoneNumberParams});
  Future<Either<Failure, UserCredential>> signInWithPhoneNumber(
      {required SignInWithPhoneNumberParams signInWithPhoneNumberParams});

  Future<Either<Failure, Either<String, Stream<TaskSnapshot>>?>>
      uploadFileToStorage(
          {required UploadFileToStorageParams uploadFileToStorageParams});
  Future<Either<Failure, void>> addUserToFirestore({required UserData user});
  Future<Either<Failure, void>> updateUserToken({required String token});
  Future<Either<Failure, UserData?>> getUserFromFirestore(
      {required String phoneNumber});
  Future<Either<Failure, List<UserData>>> getAllUsersFromFirestore();
}
