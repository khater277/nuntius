// ignore_for_file: unused_field, prefer_final_fields
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:collection/collection.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/apis/agora/agora_end_points.dart';
import 'package:nuntius_/core/local_storage/all_users_storage.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_functions.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/calls/data/models/call_info/call_info.dart';
import 'package:nuntius_/features/calls/data/models/call_model/call_model.dart';
import 'package:nuntius_/features/calls/data/repositories/calls_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

part 'calls_cubit.freezed.dart';
part 'calls_state.dart';

class CallsCubit extends Cubit<CallsState> {
  final CallsRepository callsRepository;
  final UserStorage userStorage;

  CallsCubit({required this.callsRepository, required this.userStorage})
      : super(const CallsState.initial());

  static CallsCubit get(context) => BlocProvider.of(context);

  List<UserData> users = di<AllUsersStorage>().hasData()
      ? di<AllUsersStorage>().getData()!.users ?? []
      : [];
  void initCalls({required List<UserData> users}) {
    this.users = users;
    emit(const CallsState.initCalls());
  }

  int uid = 0;
  int? remoteUid;
  bool isJoined = false;
  RtcEngine? agoraEngine;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void setupAgoraSDKEngine({
    required String userToken,
    required String rtcToken,
    required String channelName,
    required String friendPhoneNumber,
    required CallType callType,
    required bool receiveCall,
  }) async {
    emit(const CallsState.joinCallLoading());
    final callId = const Uuid().v4();
    if (callType == CallType.video) {
      await [Permission.microphone, Permission.camera].request();
    } else {
      await [Permission.microphone].request();
    }
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine!
        .initialize(const RtcEngineContext(appId: AgoraEndPoints.appId));
    if (callType == CallType.video) await agoraEngine!.enableVideo();
    agoraEngine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          isJoined = true;
          if (!receiveCall && userToken != userStorage.getData()!.token) {
            pushCallNotification(
              callType: callType,
              userToken: userToken,
              rtcToken: rtcToken,
              channelName: channelName,
            );
            addNewCall(
              friendPhoneNumber: friendPhoneNumber,
              callId: callId,
              callType: callType,
            );
          } else {
            emit(const CallsState.onJoinChannelSuccess());
          }
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          this.remoteUid = remoteUid;
          updateCall(
            callId: callId,
            friendPhoneNumber: friendPhoneNumber,
          );
          emit(const CallsState.onUserJoined());
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          this.remoteUid = null;
          emit(const CallsState.onUserOffline());
        },
        onRtcStats: (RtcConnection rtcConnection, RtcStats rtcStats) {
          print("=================>${rtcStats.duration}");
        },
        onError: (ErrorCodeType err, String msg) {
          debugPrint(
              'Error rtc engin =============================> Code = ${err.name} MSG = $msg');
        },
      ),
    );

    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    await agoraEngine!.joinChannel(
      token: rtcToken,
      channelId: channelName,
      options: options,
      uid: uid,
    );
    // emit(const CallsState.joinVoiceCall());
  }

  void pushCallNotification({
    required CallType callType,
    required String userToken,
    required String rtcToken,
    required String channelName,
  }) async {
    Map<String, dynamic> fcmBody = AppFunctions.getCallNotificationFcmBody(
      callType: callType,
      userToken: userToken,
      rtcToken: rtcToken,
      channelName: channelName,
    );
    final response = await callsRepository.pushNotification(fcmBody: fcmBody);
    response.fold(
      (failure) => emit(CallsState.pushNotificationError(failure.getMessage())),
      (result) => emit(const CallsState.onJoinChannelSuccess()),
    );
  }

  void leaveCall() async {
    emit(const CallsState.leaveCallLoading());
    isJoined = false;
    remoteUid = null;
    await agoraEngine!.leaveChannel();
    await agoraEngine!.release();
    emit(const CallsState.leaveCall());
  }

  void cancelCall({required String userToken}) async {
    emit(const CallsState.cancelCallLoading());
    Map<String, dynamic> fcmBody = {
      "to": userToken,
      "priority": "high",
      "data": {
        "type": "cancel-call",
        "userToken": userStorage.getData()!.token!,
        "senderID": userStorage.getData()!.uId!,
        "phoneNumber": userStorage.getData()!.phone!,
      }
    };
    final response = await callsRepository.pushNotification(fcmBody: fcmBody);
    response.fold(
      (failure) => emit(CallsState.cancelCallError(failure.getMessage())),
      (result) => emit(const CallsState.cancelCall()),
    );
  }

  void addNewCall({
    required String friendPhoneNumber,
    required String callId,
    required CallType callType,
  }) async {
    final response = await callsRepository.addNewCall(
      friendPhoneNumber: friendPhoneNumber,
      callId: callId,
      callType: callType,
    );

    response.fold(
      (failure) => null,
      (result) => print("==============>CALL ADDED SUCCESSFULLY"),
    );
  }

  void updateCall({
    required String callId,
    required String friendPhoneNumber,
  }) async {
    final response = await callsRepository.updateCall(
      callId: callId,
      friendPhoneNumber: friendPhoneNumber,
    );
    response.fold(
      (failure) => null,
      (result) => print("==============>CALL UPDATED SUCCESSFULLY"),
    );
  }

  List<CallInfo>? calls;
  void getCalls() async {
    emit(const CallsState.getCallsLoading());
    final response = await callsRepository.getCalls();
    response.fold(
      (failure) => emit(CallsState.getCallsError(failure.getMessage())),
      (stream) {
        stream.listen((event) {
          List<CallInfo> calls = [];
          for (var element in event.docs) {
            final callModel = CallModel.fromJson(element.data());
            final user = users.firstWhereOrNull(
                (element) => element.phone == callModel.phoneNumber);
            CallInfo callInfo = CallInfo(
              callModel: callModel,
              name: user != null ? user.name! : callModel.phoneNumber!,
              image: user != null ? user.image! : "",
            );
            calls.add(callInfo);
          }
          this.calls = calls;
          emit(const CallsState.initCalls());
          emit(const CallsState.getCalls());
        });
      },
    );
  }
}
