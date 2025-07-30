import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/apis/agora/agora_api.dart';
import 'package:nuntius/core/apis/fcm/fcm_api.dart';
import 'package:nuntius/core/firebase/firestore/calls_database.dart';
import 'package:nuntius/core/firebase/firestore/users_database.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/calls/domain/parameters/add_new_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/generate_token_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_in_call_params.dart';
import 'package:nuntius/features/messages/data/models/agora_token/agora_token_model/agora_token_model.dart';

abstract class CallsRemoteDataSource {
  Future<AgoraTokenModel> generateToken(
      {required GenerateTokenParams generateTokenParams});

  Future<void> addNewCall({required AddNewCallParams addNewCallParams});

  Future<void> updateCall({required UpdateCallParams updateCallParams});

  Stream<QuerySnapshot<Map<String, dynamic>>> getCalls();

  Future<void> updateInCall({required UpdateInCallParams updateInCallParams});
}

class CallsRemoteDataSourceImpl implements CallsRemoteDataSource {
  final AgoraApi agoraApi;
  final FcmApi fcmApi;
  final CallsDatabase callsDatabase;
  final UsersDatabase usersDatabase;
  final UserStorage userStorage;

  CallsRemoteDataSourceImpl({
    required this.agoraApi,
    required this.fcmApi,
    required this.callsDatabase,
    required this.usersDatabase,
    required this.userStorage,
  });
  @override
  Future<AgoraTokenModel> generateToken(
      {required GenerateTokenParams generateTokenParams}) {
    return agoraApi.generateToken(
        generateTokenParams.channel, generateTokenParams.uid);
  }

  @override
  Future<void> addNewCall({required AddNewCallParams addNewCallParams}) {
    return callsDatabase.addNewCall(addNewCallParams: addNewCallParams);
  }

  @override
  Future<void> updateCall({required UpdateCallParams updateCallParams}) {
    return callsDatabase.updateCall(updateCallParams: updateCallParams);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getCalls() {
    return callsDatabase.getCalls();
  }

  @override
  Future<void> updateInCall(
      {required UpdateInCallParams updateInCallParams}) async {
    await usersDatabase.updateUserData(
      phoneNumber: updateInCallParams.phoneNumber,
      data: {"inCall": updateInCallParams.inCall},
    );

    await usersDatabase.updateUserData(
      phoneNumber: userStorage.getUser()!.phone!,
      data: {"inCall": updateInCallParams.inCall},
    );
  }
}
