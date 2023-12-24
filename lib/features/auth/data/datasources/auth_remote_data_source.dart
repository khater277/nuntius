import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nuntius_/core/firebase/auth/auth.dart';
import 'package:nuntius_/core/firebase/firestore/users_database.dart';
import 'package:nuntius_/core/firebase/storage/storage.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/auth/domain/parameters/sign_in_with_phone_number_params.dart';
import 'package:nuntius_/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius_/features/auth/domain/parameters/verify_phone_number_params.dart';

abstract class AuthRemoteDataSource {
  Future<void> verifyPhoneNumber(
      {required VerifyPhoneNumberParams verifyPhoneNumberParams});

  Future<UserCredential> signInWithPhoneNumber(
      {required SignInWithPhoneNumberParams signInWithPhoneNumberParams});

  Future<Either<String, Stream<TaskSnapshot>>?> uploadImageToStorage(
      {required UploadFileToStorageParams uploadFileToStorageParams});
  Future<void> updateUserToken({required String token});

  Future<void> addUserToFirestore({required UserData user});
  Future<UserData> getUserFromFirestore({required String phoneNumber});
  Future<List<UserData>> getAllUsersFromFirestore();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final UsersDatabase usersDatabase;
  final AuthViaFirebase authViaFirebase;
  final FirebaseMedia firebaseMedia;

  AuthRemoteDataSourceImpl({
    required this.authViaFirebase,
    required this.usersDatabase,
    required this.firebaseMedia,
  });
  @override
  Future<void> verifyPhoneNumber(
      {required VerifyPhoneNumberParams verifyPhoneNumberParams}) {
    return authViaFirebase.verifyPhoneNumber(
        verifyPhoneNumberParams: verifyPhoneNumberParams);
  }

  @override
  Future<UserCredential> signInWithPhoneNumber(
      {required SignInWithPhoneNumberParams signInWithPhoneNumberParams}) {
    return authViaFirebase.signInWithPhoneNumber(
        signInWithPhoneNumberParams: signInWithPhoneNumberParams);
  }

  @override
  Future<Either<String, Stream<TaskSnapshot>>?> uploadImageToStorage(
      {required UploadFileToStorageParams uploadFileToStorageParams}) async {
    return firebaseMedia.uploadFileToStorage(
        uploadFileToStorageParams: uploadFileToStorageParams);
  }

  @override
  Future<void> addUserToFirestore({required UserData user}) {
    return usersDatabase.addUserToFirestore(user: user);
  }

  @override
  Future<UserData> getUserFromFirestore({required String phoneNumber}) {
    return usersDatabase.getUserFromFirestore(phoneNumber: phoneNumber);
  }

  @override
  Future<void> updateUserToken({required String token}) {
    return usersDatabase.updateUserData(data: {'token': token});
  }

  @override
  Future<List<UserData>> getAllUsersFromFirestore() {
    return usersDatabase.getAllUsersFromFirestore();
  }
}
