import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/core/local_storage/keys.dart';
import 'package:nuntius/features/calls/data/models/call_info/call_info.dart';
import 'package:nuntius/features/calls/data/models/call_model/call_model.dart';
import 'package:nuntius/features/calls/data/models/call_status/call_status.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';

abstract class CallsStorage {
  Future<void> init();
  bool hasData();
  List<CallInfo> getCalls();
  Future<void> saveCall({required CallInfo callInfo});
  Future<void> deleteAll();
}

class CallsStorageImpl implements CallsStorage {
  Box<CallInfo>? _box;

  final key = HiveKeys.calls;

  @override
  bool hasData() => _box!.isNotEmpty;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(CallTypeAdapter().typeId)) {
      Hive.registerAdapter(CallTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(CallStatusAdapter().typeId)) {
      Hive.registerAdapter(CallStatusAdapter());
    }
    if (!Hive.isAdapterRegistered(CallModelAdapter().typeId)) {
      Hive.registerAdapter(CallModelAdapter());
    }
    if (!Hive.isAdapterRegistered(CallInfoAdapter().typeId)) {
      Hive.registerAdapter(CallInfoAdapter());
    }
    _box = await Hive.openBox(key);
  }

  @override
  Future<void> saveCall({required CallInfo callInfo}) async {
    await _box!.put(callInfo.callModel!.callId, callInfo);
    await _box!.flush();
  }

  @override
  List<CallInfo> getCalls() => _box!.values.toList();

  @override
  Future<void> deleteAll() => _box!.deleteAll(_box!.keys);
}
