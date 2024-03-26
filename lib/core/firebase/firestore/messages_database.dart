import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/messages/domain/parameters/delete_message_params.dart';
import 'package:nuntius/features/messages/domain/parameters/send_message_params.dart';
import 'package:uuid/uuid.dart';

abstract class MessagesDatabase {
  Future<void> sendMessage({required SendMessageParams sendMessageParams});

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String phoneNumber});

  Future<void> deleteMessage(
      {required DeleteMessageParams deleteMessageParams});

  Future<void> deleteLastMessage({required String userPhone});

  Future<void> seeMessage({
    required String phoneNumber,
  });

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
      {required String phoneNumber});
}

class MessagesDatabaseImpl implements MessagesDatabase {
  final UserStorage userStorage;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  MessagesDatabaseImpl({required this.userStorage});

  @override
  Future<void> sendMessage(
      {required SendMessageParams sendMessageParams}) async {
    final String id = const Uuid().v4();

    /// add message to my database
    await _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.chats)
        .doc(sendMessageParams.phoneNumber)
        .set(
            sendMessageParams.lastMessageModel.copyWith(isRead: true).toJson());

    await _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.chats)
        .doc(sendMessageParams.phoneNumber)
        .collection(Collections.messages)
        .doc(id)
        .set(sendMessageParams.messageModel.copyWith(messageId: id).toJson());

    /// add message to friend database

    await _db
        .collection(Collections.users)
        .doc(sendMessageParams.phoneNumber)
        .collection(Collections.chats)
        .doc(userStorage.getUser()!.phone!)
        .set(sendMessageParams.lastMessageModel
            .copyWith(image: userStorage.getUser()!.image)
            .toJson());
    await _db
        .collection(Collections.users)
        .doc(sendMessageParams.phoneNumber)
        .collection(Collections.chats)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.messages)
        .doc(id)
        .set(sendMessageParams.messageModel.copyWith(messageId: id).toJson());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String phoneNumber}) {
    return _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.chats)
        .doc(phoneNumber)
        .collection(Collections.messages)
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  Future<void> deleteMessage(
      {required DeleteMessageParams deleteMessageParams}) async {
    await _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.chats)
        .doc(deleteMessageParams.userPhone)
        .collection(Collections.messages)
        .doc(deleteMessageParams.messageId)
        .update({"isDeleted": true});

    await _db
        .collection(Collections.users)
        .doc(deleteMessageParams.userPhone)
        .collection(Collections.chats)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.messages)
        .doc(deleteMessageParams.messageId)
        .update({"isDeleted": true});
  }

  @override
  Future<void> deleteLastMessage({
    required String userPhone,
  }) async {
    await _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.chats)
        .doc(userPhone)
        .update({"isDeleted": true});

    await _db
        .collection(Collections.users)
        .doc(userPhone)
        .collection(Collections.chats)
        .doc(userStorage.getUser()!.phone)
        .update({"isDeleted": true});
  }

  @override
  Future<void> seeMessage({required String phoneNumber}) async {
    _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.chats)
        .doc(phoneNumber)
        .update({"isRead": true});
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
      {required String phoneNumber}) {
    return _db.collection(Collections.users).doc(phoneNumber).snapshots();
  }
}
