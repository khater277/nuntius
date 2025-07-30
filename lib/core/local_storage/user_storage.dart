import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/core/local_storage/keys.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';

abstract class UserStorage {
  Future<void> init();
  bool hasData();
  UserData? getUser();
  Future<void> saveUser({required UserData? user});
}

class UserStorageImpl implements UserStorage {
  Box<UserData?>? _box;

  final key = HiveKeys.currentUser;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(UserDataAdapter().typeId)) {
      Hive.registerAdapter(UserDataAdapter());
    }
    _box = await Hive.openBox(key);
  }

  @override
  bool hasData() => _box!.isNotEmpty;

  @override
  UserData? getUser() => _box!.get(key);

  @override
  Future<void> saveUser({required UserData? user}) async {
    try {
      await _box!.put(key, user);
      await _box!.flush();
      print("=====> ${user.toString()}");
    } catch (e) {
      print("=====> ${e.toString()}");
    }
  }
}
