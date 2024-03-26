import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/messages/domain/parameters/delete_message_params.dart';
import 'package:nuntius/features/messages/domain/parameters/send_message_params.dart';

abstract class MessagesRepository {
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>>
      getUserStream({required String phoneNumber});

  Future<Either<Failure, void>> sendMessage(
      {required SendMessageParams sendMessageParams});
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getMessages({required String phoneNumber});

  Future<Either<Failure, Map<String, dynamic>>> pushNotification({
    required Map<String, dynamic> fcmBody,
  });

  Future<Either<Failure, void>> deleteMessage(
      {required DeleteMessageParams deleteMessageParams});

  Future<Either<Failure, void>> deleteLastMessage({required String userPhone});

  Future<Either<Failure, void>> seeMessage({required String phoneNumber});
}
