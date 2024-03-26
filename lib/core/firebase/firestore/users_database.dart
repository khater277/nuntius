import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/firebase/firestore/calls_database.dart';
import 'package:nuntius/core/firebase/firestore/chats_database.dart';
import 'package:nuntius/core/firebase/firestore/messages_database.dart';
import 'package:nuntius/core/firebase/firestore/stories_database.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';

abstract class UsersDatabase {
  Future<void> addUserToFirestore({required UserData user});
  Future<UserData?> getUserFromFirestore({required String phoneNumber});
  Future<List<UserData>> getAllUsersFromFirestore();
  Future<void> updateUserData(
      {required String phoneNumber, required Map<String, dynamic> data});
  Future<void> deleteUserAccount();
}

class UsersDatabaseImpl implements UsersDatabase {
  final ChatsDatabase _chatsDatabase;
  final StoriesDatabase _storiesDatabase;
  final CallsDatabase _callsDatabase;
  final UserStorage _userStorage;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  UsersDatabaseImpl(
      {required ChatsDatabase chatsDatabase,
      required MessagesDatabase messagesDatabase,
      required StoriesDatabase storiesDatabase,
      required CallsDatabase callsDatabase,
      required UserStorage userStorage})
      : _chatsDatabase = chatsDatabase,
        _storiesDatabase = storiesDatabase,
        _callsDatabase = callsDatabase,
        _userStorage = userStorage;

  @override
  Future<void> addUserToFirestore({required UserData user}) {
    return _db.collection(Collections.users).doc(user.phone).set(user.toJson());
  }

  @override
  Future<UserData?> getUserFromFirestore({required String phoneNumber}) async {
    final response =
        await _db.collection(Collections.users).doc(phoneNumber).get();
    try {
      return UserData.fromJson(response.data()!);
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<UserData>> getAllUsersFromFirestore() async {
    List<UserData> users = [];
    final response = await _db.collection(Collections.users).get();
    final docs = response.docs;
    if (docs.isNotEmpty) {
      for (var element in docs) {
        users.add(UserData.fromJson(element.data()));
      }
    }
    return users;
  }

  @override
  Future<void> updateUserData(
      {required String phoneNumber, required Map<String, dynamic> data}) async {
    _db.collection(Collections.users).doc(phoneNumber).update(data);
  }

  @override
  Future<void> deleteUserAccount() async {
    ///STORIES
    await _storiesDatabase.deleteAllStories();

    ///CHATS
    await _chatsDatabase.deleteAllChats();

    ///CALLS
    await _callsDatabase.deleteAllCall();

    ///USER
    await _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone)
        .delete();
  }
}
