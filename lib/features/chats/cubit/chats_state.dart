part of 'chats_cubit.dart';

@freezed
class ChatsState with _$ChatsState {
  const factory ChatsState.initial() = _Initial;
  const factory ChatsState.initChats() = _InitChats;
  const factory ChatsState.getChatsLoading() = _GetChatsLoading;
  const factory ChatsState.getChats(
    List<LastMessageModel> lastMessages,
    List<UserData> users,
  ) = _GetChats;
  const factory ChatsState.getChatsError(String errorMsg) = _GetChatsError;
  const factory ChatsState.deleteChatLoading(String phoneNumber) =
      _DeleteChatLoading;
  const factory ChatsState.deleteChat(String phoneNumber) = _DeleteChat;
  const factory ChatsState.deleteChatError(String errorMsg) = _DeleteChatError;
}
