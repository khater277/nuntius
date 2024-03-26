// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius/core/local_storage/chats_storage.dart';
import 'package:nuntius/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/chats/data/models/chats_model.dart';
import 'package:nuntius/features/chats/domain/usecases/get_chats_usecase.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/messages/data/models/last_message/last_message_model.dart';

part 'chats_cubit.freezed.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final GetChatsUsecase _getChatsUsecase;
  final HomeCubit _homeCubit;
  final ChatsStorage _chatsStorage;
  ChatsCubit({
    required GetChatsUsecase getChatsUsecase,
    required HomeCubit homeCubit,
    required ChatsStorage chatsStorage,
  })  : _getChatsUsecase = getChatsUsecase,
        _homeCubit = homeCubit,
        _chatsStorage = chatsStorage,
        super(const ChatsState.initial());

  List<ChatsModel> chats = [];

  Future<void> getChats() async {
    emit(const ChatsState.getChatsLoading());

    final response = await _getChatsUsecase.call(NoParams());
    response.fold(
      (failure) {
        chats = _chatsStorage.getAllChats();
        emit(ChatsState.getChatsError(failure.getMessage()));
      },
      (stream) async {
        if (await stream.isEmpty == false) {
          stream.listen((event) async {
            List<LastMessageModel> lastMessages = [];
            List<UserData> users = [];
            for (var doc in event.docs) {
              final phoneNumber = doc.id;
              final lastMessage = LastMessageModel.fromJson(doc.data());
              final user = _homeCubit.users
                      .firstWhereOrNull((user) => user.phone == phoneNumber) ??
                  UserData(
                    name: phoneNumber,
                    uId: lastMessage.senderID == await SharedPrefHelper.getUid()
                        ? lastMessage.receiverID
                        : lastMessage.senderID,
                    image: lastMessage.image,
                    phone: phoneNumber,
                  );
              lastMessages.add(lastMessage);
              users.add(user);
              final chatModel = ChatsModel(
                user: user,
                lastMessage: lastMessage,
                messages: _chatsStorage.getChat(phone: user.phone!) != null
                    ? _chatsStorage.getChat(phone: user.phone!)!.messages
                    : [],
              );
              _chatsStorage.saveChat(chatsModel: chatModel);
            }
            chats = _chatsStorage.getAllChats();
            emit(ChatsState.getChats(lastMessages, users));
          });
        }
      },
    );
  }
}
