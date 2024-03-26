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
}
