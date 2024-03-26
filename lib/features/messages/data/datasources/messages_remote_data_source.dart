import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/apis/fcm/fcm_api.dart';
import 'package:nuntius/core/firebase/firestore/messages_database.dart';
import 'package:nuntius/features/messages/domain/parameters/delete_message_params.dart';
import 'package:nuntius/features/messages/domain/parameters/send_message_params.dart';

abstract class MessagesRemoteDataSource {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
      {required String phoneNumber});

  Future<void> sendMessage({required SendMessageParams sendMessageParams});

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String phoneNumber});

  Future<Map<String, dynamic>> pushNotification({
    required Map<String, dynamic> fcmBody,
  });

  Future<void> deleteMessage(
      {required DeleteMessageParams deleteMessageParams});

  Future<void> deleteLastMessage({required String userPhone});

  Future<void> seeMessage({required String phoneNumber});
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final MessagesDatabase messagesDatabase;
  final FcmApi fcmApi;

  MessagesRemoteDataSourceImpl(
      {required this.messagesDatabase, required this.fcmApi});

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
      {required String phoneNumber}) {
    return messagesDatabase.getUserStream(phoneNumber: phoneNumber);
  }

  @override
  Future<void> sendMessage({required SendMessageParams sendMessageParams}) {
    return messagesDatabase.sendMessage(sendMessageParams: sendMessageParams);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String phoneNumber}) {
    return messagesDatabase.getMessages(phoneNumber: phoneNumber);
  }

  @override
  Future<Map<String, dynamic>> pushNotification(
      {required Map<String, dynamic> fcmBody}) {
    return fcmApi.pushNotification(fcmBody: fcmBody);
  }

  @override
  Future<void> deleteLastMessage({required String userPhone}) {
    return messagesDatabase.deleteLastMessage(userPhone: userPhone);
  }

  @override
  Future<void> deleteMessage(
      {required DeleteMessageParams deleteMessageParams}) {
    return messagesDatabase.deleteMessage(
        deleteMessageParams: deleteMessageParams);
  }

  @override
  Future<void> seeMessage({required String phoneNumber}) {
    return messagesDatabase.seeMessage(phoneNumber: phoneNumber);
  }
}
