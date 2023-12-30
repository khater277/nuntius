import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius_/core/firebase/collections_keys.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';

abstract class UsersDatabase {
  Future<void> addUserToFirestore({required UserData user});
  Future<UserData> getUserFromFirestore({required String phoneNumber});
  Future<List<UserData>> getAllUsersFromFirestore();
  Future<void> updateUserData({required Map<String, dynamic> data});
}

class UsersDatabaseImpl implements UsersDatabase {
  final UserStorage userStorage;

  UsersDatabaseImpl({required this.userStorage});
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> addUserToFirestore({required UserData user}) {
    return _db.collection(Collections.users).doc(user.phone).set(user.toJson());
  }

  @override
  Future<UserData> getUserFromFirestore({required String phoneNumber}) async {
    final response =
        await _db.collection(Collections.users).doc(phoneNumber).get();
    return UserData.fromJson(response.data()!);
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
  Future<void> updateUserData({required Map<String, dynamic> data}) async {
    _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone)
        .update(data);
  }
}
