import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/firestore/chats_database.dart';

abstract class ChatsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats();
}

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final ChatsDatabase chatsDatabase;

  ChatsRemoteDataSourceImpl({required this.chatsDatabase});
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    return chatsDatabase.getChats();
  }
}
