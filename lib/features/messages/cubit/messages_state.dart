part of 'messages_cubit.dart';

@freezed
class MessagesState with _$MessagesState {
  const factory MessagesState.initial() = _Initial;
  const factory MessagesState.initControllers() = _InitControllers;
  const factory MessagesState.disposeControllers() = _DisposeControllers;
  const factory MessagesState.sendMessageLoading({double? percentage}) =
      _SendMessageLoading;
  const factory MessagesState.sendMessage() = _SendMessage;
  const factory MessagesState.sendMessageError(String errorMsg) =
      _SendMessageError;
  const factory MessagesState.createVideosThumbnails() =
      _CreateVideosThumbnails;
  const factory MessagesState.getMessagesLoading() = _GetMessagesLoading;
  const factory MessagesState.getMessages(List<MessageModel> messages) =
      _GetMessages;

  const factory MessagesState.receiveMessage() = _ReceiveMessage;

  const factory MessagesState.getUserLoading() = _GetUserLoading;
  const factory MessagesState.getUser(UserData user) = _GetUser;

  const factory MessagesState.getMessagesError(String errorMsg) =
      _GetMessagesError;
  const factory MessagesState.pickMediaMessageLoading() =
      _PickMediaMessageLoading;
  const factory MessagesState.pickMediaMessage(MessageType messageType) =
      _PickMediaMessage;
  const factory MessagesState.pickMediaMessageError(String errorMsg) =
      _PickMediaMessageError;
  const factory MessagesState.closeMediaContainer() = _CloseMediaContainer;

  const factory MessagesState.downloadDocMessageLoading(
      {required String messageId,
      double? percentage}) = _DownloadDocMessageLoading;
  const factory MessagesState.downloadDocMessage(String messageId) =
      _DownloadDocMessage;
  const factory MessagesState.downloadDocMessageError(
      String messageId, String errorMsg) = _DownloadDocMessageError;

  const factory MessagesState.openDocMessageLoading() = _OpenDocMessageLoading;
  const factory MessagesState.openDocMessage() = _OpenDocMessage;
  const factory MessagesState.openDocMessageError(String errorMsg) =
      _OpenDocMessageError;

  const factory MessagesState.deleteMessageLoading(String messageId) =
      _DeleteMessageLoading;
  const factory MessagesState.deleteMessage() = _DeleteMessage;
  const factory MessagesState.deleteMessageError(String errorMsg) =
      _DeleteMessageError;

  const factory MessagesState.generateTokenLoading(CallType callType) =
      _GenerateTokenLoading;
  const factory MessagesState.generateToken(
    String token,
    String channelName,
    CallType callType,
  ) = _GenerateToken;
  const factory MessagesState.generateTokenError(String errorMsg) =
      _GenerateTokenError;
  const factory MessagesState.setupVoiceSDKEngine() = _SetupVoiceSDKEngine;
  const factory MessagesState.onJoinChannelSuccess() = _OnJoinChannelSuccess;
  const factory MessagesState.onUserJoined() = _OnUserJoined;
  const factory MessagesState.onUserOffline() = _OnUserOffline;
  const factory MessagesState.joinVoiceCallLoading() = _JoinVoiceCallLoading;
  const factory MessagesState.joinVoiceCall() = _JoinVoiceCall;
  const factory MessagesState.joinVoiceCallError(String errorMsg) =
      _JoinVoiceCallError;
  const factory MessagesState.leaveVoiceCallLoading() = _LeaveVoiceCallLoading;
  const factory MessagesState.leaveVoiceCall() = _LeaveVoiceCall;
  const factory MessagesState.scrollDownLoading() = _ScrollDownLoading;
  const factory MessagesState.scrollDown() = _ScrollDown;
}
