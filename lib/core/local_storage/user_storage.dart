import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius_/core/local_storage/keys.dart';
import 'package:nuntius_/core/local_storage/local_storage.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';

class UserStorage implements LocalStorage<UserData?> {
  Box<UserData?>? _box;

  @override
  String key() => HiveKeys.currentUser;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(UserDataAdapter().typeId)) {
      Hive.registerAdapter(UserDataAdapter());
    }
    _box = await Hive.openBox(key());
  }

  @override
  bool hasData() => _box!.isNotEmpty;

  @override
  UserData? getData() => _box!.get(key());

  @override
  List<UserData?> getAllData() => _box!.values.toList();

  @override
  Future<void> saveData({required UserData? data}) async {
    await _box!.put(key(), data);
    await _box!.flush();
  }

  @override
  Future<void> delete() => _box!.delete(key());
}
