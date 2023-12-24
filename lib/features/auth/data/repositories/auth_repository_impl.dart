import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nuntius_/core/errors/failures.dart';
import 'package:nuntius_/core/local_storage/all_users_storage.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/network/network_info.dart';
import 'package:nuntius_/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius_/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:nuntius_/features/auth/data/models/all_users/all_users_model.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/auth/domain/parameters/sign_in_with_phone_number_params.dart';
import 'package:nuntius_/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius_/features/auth/domain/parameters/verify_phone_number_params.dart';
import 'package:nuntius_/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  final UserStorage userStorage;
  final AllUsersStorage allUsersStorage;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
    required this.userStorage,
    required this.allUsersStorage,
  });

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(
      {required VerifyPhoneNumberParams verifyPhoneNumberParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = await authRemoteDataSource.verifyPhoneNumber(
            verifyPhoneNumberParams: verifyPhoneNumberParams);
        return Right(response);
      } on FirebaseAuthException catch (error) {
        return Left(ServerFailure(
          error: error,
          type: NetworkErrorTypes.auth,
        ));
      }
    } else {
      return Left(
        ServerFailure(
          error: NoInternetConnection(),
          type: NetworkErrorTypes.noInternetConnection,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithPhoneNumber(
      {required SignInWithPhoneNumberParams
          signInWithPhoneNumberParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = await authRemoteDataSource.signInWithPhoneNumber(
            signInWithPhoneNumberParams: signInWithPhoneNumberParams);

        SharedPrefHelper.setUid(uId: response.user!.uid);
        final result = await getUserFromFirestore(
            phoneNumber: response.user!.phoneNumber!);
        result.fold(
          (failure) => userStorage.saveData(data: null),
          (user) => userStorage.saveData(data: user),
        );
        return Right(response);
      } on FirebaseAuthException catch (error) {
        print("ERROR TYPE =====> ${error.toString()}");
        return Left(ServerFailure(
          error: error,
          type: NetworkErrorTypes.auth,
        ));
      } catch (error) {
        print("ERROR TYPE =====> ${error.runtimeType}");
        return Left(ServerFailure(
          error: FirebaseAuthException(code: 'request-canceled'),
          type: NetworkErrorTypes.auth,
        ));
      }
    } else {
      return Left(
        ServerFailure(
          error: NoInternetConnection(),
          type: NetworkErrorTypes.noInternetConnection,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Either<String, Stream<TaskSnapshot>>?>>
      uploadFileToStorage(
          {required UploadFileToStorageParams
              uploadFileToStorageParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = await authRemoteDataSource.uploadImageToStorage(
            uploadFileToStorageParams: uploadFileToStorageParams);
        return Right(response);
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.storage));
      }
    } else {
      return Left(
        ServerFailure(
          error: NoInternetConnection(),
          type: NetworkErrorTypes.noInternetConnection,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addUserToFirestore(
      {required UserData user}) async {
    if (await networkInfo.connected()) {
      try {
        final response =
            await authRemoteDataSource.addUserToFirestore(user: user);
        return Right(response);
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.firestore));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserFromFirestore(
      {required String phoneNumber}) async {
    try {
      final response = await authRemoteDataSource.getUserFromFirestore(
          phoneNumber: phoneNumber);
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserToken({required String token}) async {
    if (await networkInfo.connected()) {
      try {
        final response =
            await authRemoteDataSource.updateUserToken(token: token);
        return Right(response);
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.firestore));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }

  @override
  Future<Either<Failure, List<UserData>>> getAllUsersFromFirestore() async {
    if (await networkInfo.connected()) {
      try {
        final response = await authRemoteDataSource.getAllUsersFromFirestore();
        allUsersStorage.saveData(data: AllUsersModel(users: response));
        return Right(response);
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.firestore));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }
}
