import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius_/core/local_storage/keys.dart';
import 'package:nuntius_/core/local_storage/local_storage.dart';
import 'package:nuntius_/features/auth/data/models/all_users/all_users_model.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';

class AllUsersStorage implements LocalStorage<AllUsersModel?> {
  Box<AllUsersModel?>? _box;

  @override
  String key() => HiveKeys.allUsers;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(UserDataAdapter().typeId)) {
      Hive.registerAdapter(UserDataAdapter());
    }
    if (!Hive.isAdapterRegistered(AllUsersModelAdapter().typeId)) {
      Hive.registerAdapter(AllUsersModelAdapter());
    }
    _box = await Hive.openBox(key());
  }

  @override
  bool hasData() => _box!.isNotEmpty;

  @override
  AllUsersModel? getData() => _box!.get(key());

  @override
  List<AllUsersModel?> getAllData() => _box!.values.toList();

  @override
  Future<void> saveData({required AllUsersModel? data}) async {
    await _box!.put(key(), data);
    await _box!.flush();
  }

  @override
  Future<void> delete() => _box!.delete(key());
}
