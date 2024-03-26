import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/core/local_storage/keys.dart';
import 'package:nuntius/features/auth/data/models/all_users/all_users_model.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';

abstract class AllUsersStorage {
  Future<void> init();
  bool hasData();
  AllUsersModel? getAllUsers();
  Future<void> saveAllUsers({required AllUsersModel? allUsers});
}

class AllUsersStorageImpl implements AllUsersStorage {
  Box<AllUsersModel?>? _box;

  final key = HiveKeys.allUsers;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(UserDataAdapter().typeId)) {
      Hive.registerAdapter(UserDataAdapter());
    }
    if (!Hive.isAdapterRegistered(AllUsersModelAdapter().typeId)) {
      Hive.registerAdapter(AllUsersModelAdapter());
    }
    _box = await Hive.openBox(key);
  }

  @override
  bool hasData() => _box!.isNotEmpty;

  @override
  AllUsersModel? getAllUsers() => _box!.get(key);

  @override
  Future<void> saveAllUsers({required AllUsersModel? allUsers}) async {
    await _box!.put(key, allUsers);
    await _box!.flush();
  }
}
