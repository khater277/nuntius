import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nuntius_/core/errors/failures.dart';
import 'package:nuntius_/core/network/network_info.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/features/calls/data/datasources/calls_remote_data_source.dart';
import 'package:nuntius_/features/calls/data/repositories/calls_repository.dart';
import 'package:nuntius_/features/messages/data/models/agora_token/agora_token_model/agora_token_model.dart';

class CallsRepositoryImpl implements CallsRepository {
  final CallsRemoteDataSource callsRemoteDataSource;
  final NetworkInfo networkInfo;

  CallsRepositoryImpl(
      {required this.callsRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, AgoraTokenModel>> generateToken(
      {required String channel, required String uid}) async {
    try {
      final response =
          await callsRemoteDataSource.generateToken(channel: channel, uid: uid);
      return Right(response);
    } on DioException catch (error) {
      return Left(ServerFailure(
        error: error,
        type: NetworkErrorTypes.api,
      ));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> pushNotification(
      {required Map<String, dynamic> fcmBody}) async {
    try {
      final response =
          await callsRemoteDataSource.pushNotification(fcmBody: fcmBody);
      return Right(response);
    } on DioException catch (error) {
      return Left(ServerFailure(error: error, type: NetworkErrorTypes.api));
    }
  }

  @override
  Future<Either<Failure, void>> addNewCall({
    required String friendPhoneNumber,
    required String callId,
    required CallType callType,
  }) async {
    if (await networkInfo.connected()) {
      try {
        final response = callsRemoteDataSource.addNewCall(
          friendPhoneNumber: friendPhoneNumber,
          callId: callId,
          callType: callType,
        );
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
  Future<Either<Failure, void>> updateCall({
    required String callId,
    required String friendPhoneNumber,
  }) async {
    if (await networkInfo.connected()) {
      try {
        final response = await callsRemoteDataSource.updateCall(
            callId: callId, friendPhoneNumber: friendPhoneNumber);
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
}
