import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/firestore/chats_database.dart';

abstract class ChatsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats();
  Future<void> deleteChat({required String phoneNumber});
}

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final ChatsDatabase chatsDatabase;

  ChatsRemoteDataSourceImpl({required this.chatsDatabase});
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    return chatsDatabase.getChats();
  }

  @override
  Future<void> deleteChat({required String phoneNumber}) async {
    return chatsDatabase.deleteChat(phoneNumber: phoneNumber);
  }
}
