import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';

abstract class ChatsDatabase {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats();
  Future<void> deleteChat({required String phoneNumber});
  Future<void> deleteAllChats();
}

class ChatsDatabaseImpl implements ChatsDatabase {
  final UserStorage _userStorage;

  ChatsDatabaseImpl({required UserStorage userStorage})
      : _userStorage = userStorage;
  final _db = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    return _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone!)
        .collection(Collections.chats)
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  Future<void> deleteChat({required String phoneNumber}) async {
    final chat = _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone)
        .collection(Collections.chats)
        .doc(phoneNumber);

    final messages = await chat.collection(Collections.messages).get();
    for (var message in messages.docs) {
      await message.reference.delete();
    }
    await chat.delete();
  }

  @override
  Future<void> deleteAllChats() async {
    final allChats = await _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone)
        .collection(Collections.chats)
        .get();
    for (var chat in allChats.docs) {
      final messages =
          await chat.reference.collection(Collections.messages).get();
      for (var message in messages.docs) {
        await message.reference.delete();
      }
      await chat.reference.delete();
    }
  }
}
