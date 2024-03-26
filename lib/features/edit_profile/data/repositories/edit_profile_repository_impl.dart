import 'package:dartz/dartz.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/core/network/network_info.dart';
import 'package:nuntius/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:nuntius/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final NetworkInfo networkInfo;
  final EditProfileRemoteDataSource editProfileRemoteDataSource;

  EditProfileRepositoryImpl(
      {required this.networkInfo, required this.editProfileRemoteDataSource});
  @override
  Future<Either<Failure, void>> updateProfileData(
      {required Map<String, dynamic> data}) async {
    if (await networkInfo.connected()) {
      try {
        final response =
            await editProfileRemoteDataSource.updateProfileData(data: data);
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
  Future<Either<Failure, void>> deleteAccount() async {
    if (await networkInfo.connected()) {
      try {
        final response = await editProfileRemoteDataSource.deleteAccount();
        return Right(response);
      } on FirebaseAuthException catch (error) {
        return Left(ServerFailure(error: error, type: NetworkErrorTypes.auth));
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
