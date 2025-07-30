import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/core/network/network_info.dart';
import 'package:nuntius/features/messages/data/datasources/messages_remote_data_source.dart';
import 'package:nuntius/features/messages/domain/parameters/delete_message_params.dart';
import 'package:nuntius/features/messages/domain/parameters/send_message_params.dart';
import 'package:nuntius/features/messages/domain/repository/messages_repository.dart';

import '../../../../core/apis/fcm/oauth_token.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource messagesRemoteDataSource;
  final NetworkInfo networkInfo;

  MessagesRepositoryImpl({
    required this.messagesRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, void>> sendMessage(
      {required SendMessageParams sendMessageParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = messagesRemoteDataSource.sendMessage(
            sendMessageParams: sendMessageParams);
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
      getMessages({required String phoneNumber}) async {
    try {
      final response =
          messagesRemoteDataSource.getMessages(phoneNumber: phoneNumber);
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, String>> pushNotification(
      {required Map<String, dynamic> fcmBody}) async {
    try {
      try {
        final token = await FirebaseAccessToken.getToken();
        final response = await messagesRemoteDataSource.pushNotification(
          fcmBody: fcmBody,
          token: token,
        );
        return Right(response);
      } catch (error) {
        print("===========> ${error.toString()}");
        return Left(ServerFailure(
            error: Exception('error'), type: NetworkErrorTypes.api));
      }
    } on DioException catch (error) {
      return Left(ServerFailure(error: error, type: NetworkErrorTypes.api));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLastMessage(
      {required String userPhone}) async {
    try {
      final response = await messagesRemoteDataSource.deleteLastMessage(
          userPhone: userPhone);
      return Right(response);
    } on DioException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(
      {required DeleteMessageParams deleteMessageParams}) async {
    if (await networkInfo.connected()) {
      try {
        final response = messagesRemoteDataSource.deleteMessage(
            deleteMessageParams: deleteMessageParams);
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
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>>
      getUserStream({required String phoneNumber}) async {
    try {
      final response =
          messagesRemoteDataSource.getUserStream(phoneNumber: phoneNumber);
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, void>> seeMessage(
      {required String phoneNumber}) async {
    try {
      final response =
          messagesRemoteDataSource.seeMessage(phoneNumber: phoneNumber);
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }
}
