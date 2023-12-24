import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius_/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius_/features/chats/domain/usecases/get_chats_usecase.dart';
import 'package:nuntius_/features/home/cubit/home_cubit.dart';
import 'package:nuntius_/features/messages/data/models/last_message/last_message_model.dart';

part 'chats_cubit.freezed.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final GetChatsUsecase _getChatsUsecase;
  final HomeCubit _homeCubit;
  ChatsCubit(
      {required GetChatsUsecase getChatsUsecase, required HomeCubit homeCubit})
      : _getChatsUsecase = getChatsUsecase,
        _homeCubit = homeCubit,
        super(const ChatsState.initial());

  List<LastMessageModel> lastMessages = [];
  List<UserData> users = [];

  void getChats() async {
    emit(const ChatsState.getChatsLoading());
    final response = await _getChatsUsecase.call(NoParams());
    response.fold(
      (failure) => emit(ChatsState.getChatsError(failure.getMessage())),
      (snapshots) {
        snapshots.listen((event) async {
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
          }
          this.lastMessages = lastMessages;
          this.users = users;
          emit(ChatsState.getChats(lastMessages, users));
        });
      },
    );
  }
}
