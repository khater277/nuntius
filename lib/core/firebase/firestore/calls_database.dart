import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/calls/data/models/call_model/call_model.dart';
import 'package:nuntius/features/calls/data/models/call_status/call_status.dart';
import 'package:nuntius/features/calls/domain/parameters/add_new_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_call_params.dart';

abstract class CallsDatabase {
  Future<void> addNewCall({required AddNewCallParams addNewCallParams});

  Future<void> updateCall({required UpdateCallParams updateCallParams});

  Stream<QuerySnapshot<Map<String, dynamic>>> getCalls();

  Future<void> deleteCall({required String callId});
  Future<void> deleteAllCall();
}

class CallsDatabaseImpl implements CallsDatabase {
  final UserStorage _userStorage;

  CallsDatabaseImpl({required UserStorage userStorage})
      : _userStorage = userStorage;

  final _db = FirebaseFirestore.instance;

  @override
  Future<void> addNewCall({required AddNewCallParams addNewCallParams}) async {
    final dateTime = DateTime.now().toUtc().toString();
    await _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone!)
        .collection(Collections.calls)
        .doc(addNewCallParams.callId)
        .set(CallModel(
          callId: addNewCallParams.callId,
          phoneNumber: addNewCallParams.friendPhoneNumber,
          callType: addNewCallParams.callType,
          callStatus: CallStatus.outComingNoResponse,
          dateTime: dateTime,
        ).toJson());

    await _db
        .collection(Collections.users)
        .doc(addNewCallParams.friendPhoneNumber)
        .collection(Collections.calls)
        .doc(addNewCallParams.callId)
        .set(CallModel(
          callId: addNewCallParams.callId,
          phoneNumber: _userStorage.getUser()!.phone!,
          callType: addNewCallParams.callType,
          callStatus: CallStatus.inComingNoResponse,
          dateTime: dateTime,
        ).toJson());
  }

  @override
  Future<void> updateCall({required UpdateCallParams updateCallParams}) async {
    await _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone!)
        .collection(Collections.calls)
        .doc(updateCallParams.callId)
        .update({"callStatus": CallStatus.outComing.name});

    await _db
        .collection(Collections.users)
        .doc(updateCallParams.friendPhoneNumber)
        .collection(Collections.calls)
        .doc(updateCallParams.callId)
        .update({"callStatus": CallStatus.inComing.name});
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getCalls() {
    return _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone!)
        .collection(Collections.calls)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  @override
  Future<void> deleteCall({required String callId}) async {
    await _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone)
        .collection(Collections.calls)
        .doc(callId)
        .delete();
  }

  @override
  Future<void> deleteAllCall() async {
    final allCalls = await _db
        .collection(Collections.users)
        .doc(_userStorage.getUser()!.phone)
        .collection(Collections.calls)
        .get();
    for (var call in allCalls.docs) {
      call.reference.delete();
    }
  }
}
