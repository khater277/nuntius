import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius_/core/apis/agora/agora_api.dart';
import 'package:nuntius_/core/apis/fcm/fcm_api.dart';
import 'package:nuntius_/core/firebase/firestore/calls_database.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/features/messages/data/models/agora_token/agora_token_model/agora_token_model.dart';

abstract class CallsRemoteDataSource {
  Future<AgoraTokenModel> generateToken(
      {required String channel, required String uid});

  Future<Map<String, dynamic>> pushNotification({
    required Map<String, dynamic> fcmBody,
  });

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

class CallsRemoteDataSourceImpl implements CallsRemoteDataSource {
  final AgoraApi agoraApi;
  final FcmApi fcmApi;
  final CallsDatabase callsDatabase;

  CallsRemoteDataSourceImpl({
    required this.agoraApi,
    required this.fcmApi,
    required this.callsDatabase,
  });
  @override
  Future<AgoraTokenModel> generateToken(
      {required String channel, required String uid}) {
    return agoraApi.generateToken(channel, uid);
  }

  @override
  Future<Map<String, dynamic>> pushNotification(
      {required Map<String, dynamic> fcmBody}) {
    return fcmApi.pushNotification(fcmBody: fcmBody);
  }

  @override
  Future<void> addNewCall({
    required String friendPhoneNumber,
    required String callId,
    required CallType callType,
  }) {
    return callsDatabase.addNewCall(
      friendPhoneNumber: friendPhoneNumber,
      callId: callId,
      callType: callType,
    );
  }

  @override
  Future<void> updateCall({
    required String callId,
    required String friendPhoneNumber,
  }) {
    return callsDatabase.updateCall(
      callId: callId,
      friendPhoneNumber: friendPhoneNumber,
    );
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getCalls() {
    return callsDatabase.getCalls();
  }
}
