part of 'calls_cubit.dart';

@freezed
class CallsState with _$CallsState {
  const factory CallsState.initial() = _Initial;
  const factory CallsState.initCalls() = _InitCalls;
  const factory CallsState.generateTokenLoading() = _GenerateTokenLoading;
  const factory CallsState.generateTokenSuccess(String token) =
      _GenerateTokenSuccess;
  const factory CallsState.generateTokenError(String errorMsg) =
      _GenerateTokenError;
  const factory CallsState.setupSDKEngine() = _SetupSDKEngine;
  const factory CallsState.pushNotificationError(String errorMsg) =
      _PushNotificationError;

  const factory CallsState.joinCallLoading() = _JoinCallLoading;
  const factory CallsState.onJoinChannelSuccess() = _OnJoinChannelSuccess;
  const factory CallsState.onUserJoined() = _OnUserJoined;
  const factory CallsState.onUserOffline() = _OnUserOffline;
  const factory CallsState.leaveCallLoading() = _LeaveCallLoading;
  const factory CallsState.leaveCall() = _LeaveCall;
  const factory CallsState.cancelCallLoading() = _CancelCallLoading;
  const factory CallsState.cancelCall() = _CancelCall;
  const factory CallsState.cancelCallError(String errorMsg) = _CancelCallError;
  const factory CallsState.getCallsLoading() = _GetCallsLoading;
  const factory CallsState.getCalls() = _GetCalls;
  const factory CallsState.getCallsError(String errorMsg) = _GetCallsError;
}
