import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius_/core/firebase/collections_keys.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/features/calls/data/models/call_model/call_model.dart';

abstract class CallsDatabase {
  Future<void> addNewCall({
    required String friendPhoneNumber,
    required String callId,
    required CallType callType,
  });

  Future<void> updateCall({
    required String callId,
    required String friendPhoneNumber,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getCalls();
}

class CallsDatabaseImpl implements CallsDatabase {
  final UserStorage userStorage;
  final _db = FirebaseFirestore.instance;
  CallsDatabaseImpl({required this.userStorage});

  @override
  Future<void> addNewCall({
    required String friendPhoneNumber,
    required String callId,
    required CallType callType,
  }) async {
    final dateTime = DateTime.now().toUtc().toString();
    _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.calls)
        .doc(callId)
        .set(CallModel(
          callId: callId,
          phoneNumber: friendPhoneNumber,
          callType: callType,
          callStatus: CallStatus.outComingNoResponse,
          dateTime: dateTime,
        ).toJson());

    _db
        .collection(Collections.users)
        .doc(friendPhoneNumber)
        .collection(Collections.calls)
        .doc(callId)
        .set(CallModel(
          callId: callId,
          phoneNumber: userStorage.getUser()!.phone!,
          callType: callType,
          callStatus: CallStatus.inComingNoResponse,
          dateTime: dateTime,
        ).toJson());
  }

  @override
  Future<void> updateCall({
    required String callId,
    required String friendPhoneNumber,
  }) async {
    _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.calls)
        .doc(callId)
        .update({"callStatus": CallStatus.outComing.name});

    _db
        .collection(Collections.users)
        .doc(friendPhoneNumber)
        .collection(Collections.calls)
        .doc(callId)
        .update({"callStatus": CallStatus.inComing.name});
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getCalls() {
    return _db
        .collection(Collections.users)
        .doc(userStorage.getUser()!.phone!)
        .collection(Collections.calls)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}
