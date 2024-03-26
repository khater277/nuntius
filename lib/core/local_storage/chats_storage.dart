import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/core/local_storage/keys.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/chats/data/models/chats_model.dart';
import 'package:nuntius/features/messages/data/models/last_message/last_message_model.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';

abstract class ChatsStorage {
  Future<void> init();
  bool hasData();
  ChatsModel? getChat({required String phone});
  List<ChatsModel> getAllChats();
  Future<void> saveChat({required ChatsModel chatsModel});
  Future<void> deleteAll();
}

class ChatsStorageImpl implements ChatsStorage {
  Box<ChatsModel>? _box;

  final key = HiveKeys.chats;

  @override
  ChatsModel? getChat({required String phone}) => _box!.get(phone);

  @override
  bool hasData() => _box!.isNotEmpty;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(UserDataAdapter().typeId)) {
      Hive.registerAdapter(UserDataAdapter());
    }
    if (!Hive.isAdapterRegistered(MessageModelAdapter().typeId)) {
      Hive.registerAdapter(MessageModelAdapter());
    }
    if (!Hive.isAdapterRegistered(LastMessageModelAdapter().typeId)) {
      Hive.registerAdapter(LastMessageModelAdapter());
    }
    if (!Hive.isAdapterRegistered(ChatsModelAdapter().typeId)) {
      Hive.registerAdapter(ChatsModelAdapter());
    }
    _box = await Hive.openBox(key);
  }

  @override
  Future<void> saveChat({required ChatsModel chatsModel}) async {
    await _box!.put(chatsModel.user!.phone!, chatsModel);
    await _box!.flush();
  }

  @override
  List<ChatsModel> getAllChats() => _box!.values.toList();

  @override
  Future<void> deleteAll() => _box!.deleteAll(_box!.keys);
}
