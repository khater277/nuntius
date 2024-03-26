import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/core/network/network_info.dart';
import 'package:nuntius/features/calls/data/datasources/calls_remote_data_source.dart';
import 'package:nuntius/features/calls/domain/parameters/add_new_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/generate_token_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_in_call_params.dart';
import 'package:nuntius/features/calls/domain/repositories/calls_repository.dart';
import 'package:nuntius/features/messages/data/models/agora_token/agora_token_model/agora_token_model.dart';

class CallsRepositoryImpl implements CallsRepository {
  final CallsRemoteDataSource callsRemoteDataSource;
  final NetworkInfo networkInfo;

  CallsRepositoryImpl(
      {required this.callsRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, AgoraTokenModel>> generateToken(
      {required GenerateTokenParams generateTokenParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = await callsRemoteDataSource.generateToken(
            generateTokenParams: generateTokenParams);
        return Right(response);
      } on DioException catch (error) {
        return Left(ServerFailure(
          error: error,
          type: NetworkErrorTypes.api,
        ));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> addNewCall(
      {required AddNewCallParams addNewCallParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = callsRemoteDataSource.addNewCall(
            addNewCallParams: addNewCallParams);
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
  Future<Either<Failure, void>> updateCall(
      {required UpdateCallParams updateCallParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = await callsRemoteDataSource.updateCall(
            updateCallParams: updateCallParams);
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
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getCalls() async {
    try {
      final response = callsRemoteDataSource.getCalls();
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, void>> updateInCallUsecase(
      UpdateInCallParams updateInCallParams) async {
    try {
      final response = callsRemoteDataSource.updateInCall(
          updateInCallParams: updateInCallParams);
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }
}
