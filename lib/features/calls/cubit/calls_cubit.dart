// ignore_for_file: unused_field, prefer_final_fields
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius/core/apis/agora/agora_end_points.dart';
import 'package:nuntius/core/local_storage/calls_storage.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_functions.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/calls/data/models/call_info/call_info.dart';
import 'package:nuntius/features/calls/data/models/call_model/call_model.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/calls/domain/parameters/add_new_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_in_call_params.dart';
import 'package:nuntius/features/calls/domain/usecases/add_new_call_usecase.dart';
import 'package:nuntius/features/calls/domain/usecases/get_calls_usecase.dart';
import 'package:nuntius/features/calls/domain/usecases/update_call_usecase.dart';
import 'package:nuntius/features/calls/domain/usecases/update_in_call_usecase.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/messages/domain/usecases/push_notification_usecase.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

part 'calls_cubit.freezed.dart';
part 'calls_state.dart';

class CallsCubit extends Cubit<CallsState> {
  final HomeCubit _homeCubit;
  final UserStorage _userStorage;
  final CallsStorage _callsStorage;
  final GetCallsUsecase _getCallsUsecase;
  final AddNewCallUsecase _addNewCallUsecase;
  final UpdateCallUsecase _updateCallUsecase;
  final UpdateInCallUsecase _updateInCallUsecase;
  final PushNotificationUsecase _pushNotificationUsecase;

  CallsCubit({
    required HomeCubit homeCubit,
    required UserStorage userStorage,
    required CallsStorage callsStorage,
    required GetCallsUsecase getCallsUsecase,
    required AddNewCallUsecase addNewCallUsecase,
    required UpdateCallUsecase updateCallUsecase,
    required UpdateInCallUsecase updateInCallUsecase,
    required PushNotificationUsecase pushNotificationUsecase,
  })  : _homeCubit = homeCubit,
        _callsStorage = callsStorage,
        _userStorage = userStorage,
        _getCallsUsecase = getCallsUsecase,
        _addNewCallUsecase = addNewCallUsecase,
        _updateCallUsecase = updateCallUsecase,
        _updateInCallUsecase = updateInCallUsecase,
        _pushNotificationUsecase = pushNotificationUsecase,
        super(const CallsState.initial());

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
          isJoined = true;
          if (!receiveCall) {
            if (userToken != _userStorage.getUser()!.token) {
              pushCallNotification(
                notificationType: NotificationType.receiveCall,
                userToken: userToken,
                callType: callType,
                rtcToken: rtcToken,
                channelName: channelName,
              );
            }
            await _updateInCallUsecase.call(UpdateInCallParams(
                phoneNumber: friendPhoneNumber, inCall: true));
            addNewCall(
              friendPhoneNumber: friendPhoneNumber,
              callId: callId,
              callType: callType,
            );
          } else {
            emit(const CallsState.onJoinChannelSuccess());
          }
        },
        onLeaveChannel: (connection, stats) async {
          isJoined = false;
          if (!receiveCall) {
            await _updateInCallUsecase.call(UpdateInCallParams(
                phoneNumber: friendPhoneNumber, inCall: false));
          }
          emit(CallsState.onLeaveChannel(callId));
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          this.remoteUid = remoteUid;
          updateCall(
            callId: callId,
            friendPhoneNumber: friendPhoneNumber,
          );
          emit(CallsState.onUserJoined(remoteUid));
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          this.remoteUid = null;
          emit(CallsState.onLeaveChannel(callId));
          // emit(const CallsState.onUserOffline());
        },
        onLocalVideoStateChanged: (source, state, error) {
          if (state.index == 1) {
            debugPrint("A777777777777777777777A");
            emit(const CallsState.myVideoViewCreated());
          }
        },

        // onRemoteVideoStateChanged:
        //     (connection, remoteUid, state, reason, elapsed) {
        //   if (state.index == 1) {
        //     emit(const CallsState.friendVideoViewCreated());
        //   }
        // },
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

  void remoteUserJoined() {
    remoteUid = 0;
    emit(CallsState.onUserJoined(remoteUid!));
  }

  bool mute = false;
  void toggleMute() async {
    mute = !mute;
    await agoraEngine!.muteLocalAudioStream(mute);
    emit(CallsState.toggleMute(mute));
  }

  bool speaker = false;
  void toggleSpeaker() async {
    speaker = !speaker;
    await agoraEngine!.setEnableSpeakerphone(speaker);
    emit(CallsState.toggleSpeaker(speaker));
  }

  void pushCallNotification({
    required NotificationType notificationType,
    required String userToken,
    CallType? callType,
    String? rtcToken,
    String? channelName,
  }) async {
    Map<String, dynamic> fcmBody = AppFunctions.getCallNotificationFcmBody(
      notificationType: notificationType,
      userToken: userToken,
      callType: callType,
      rtcToken: rtcToken,
      channelName: channelName,
    );
    await _pushNotificationUsecase.call(fcmBody);
    // response.fold(
    //   (failure) => emit(CallsState.pushNotificationError(failure.getMessage())),
    //   (result) => null,
    // );
  }

  void leaveCall() async {
    emit(const CallsState.leaveCallLoading());
    isJoined = false;
    remoteUid = null;
    mute = false;
    speaker = false;
    await agoraEngine!.leaveChannel();
    await agoraEngine!.release();
    emit(const CallsState.leaveCall());
  }

  void cancelCall() async {
    emit(CallsState.onLeaveChannel(const Uuid().v4()));
  }

  void addNewCall({
    required String friendPhoneNumber,
    required String callId,
    required CallType callType,
  }) async {
    await _addNewCallUsecase.call(AddNewCallParams(
      friendPhoneNumber: friendPhoneNumber,
      callId: callId,
      callType: callType,
    ));

    emit(const CallsState.onJoinChannelSuccess());
  }

  void updateCall({
    required String callId,
    required String friendPhoneNumber,
  }) async {
    await _updateCallUsecase(UpdateCallParams(
      callId: callId,
      friendPhoneNumber: friendPhoneNumber,
    ));
    emit(CallsState.onUserJoined(remoteUid!));
  }

  List<CallInfo> calls = [];
  Future<void> getCalls() async {
    emit(const CallsState.getCallsLoading());
    final response = await _getCallsUsecase.call(NoParams());
    response.fold(
      (failure) {
        calls = _callsStorage.getCalls();
        emit(CallsState.getCallsError(failure.getMessage()));
      },
      (stream) async {
        if (await stream.isEmpty == false) {
          stream.listen((event) {
            List<CallInfo> calls = [];
            for (var element in event.docs) {
              final callModel = CallModel.fromJson(element.data());
              final user = _homeCubit.users.firstWhereOrNull(
                  (element) => element.phone == callModel.phoneNumber);
              CallInfo callInfo = CallInfo(
                callModel: callModel,
                name: user != null ? user.name! : callModel.phoneNumber!,
                image: user != null ? user.image! : "",
              );
              calls.add(callInfo);
              _callsStorage.saveCall(callInfo: callInfo);
            }
            this.calls = calls;
            emit(CallsState.getCalls(calls));
          });
        }
      },
    );
  }
}
