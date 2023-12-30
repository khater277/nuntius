import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius_/core/firebase/collections_keys.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';

abstract class ChatsDatabase {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats();
}

class ChatsDatabaseImpl implements ChatsDatabase {
  final UserStorage userStorage;
  final _db = FirebaseFirestore.instance;
  ChatsDatabaseImpl({required this.userStorage});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    return _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.chats)
        .orderBy('date', descending: true)
        .snapshots();
  }
}
