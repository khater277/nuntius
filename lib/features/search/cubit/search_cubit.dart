import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/chats/cubit/chats_cubit.dart';
import 'package:nuntius/features/chats/data/models/chats_model.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeCubit _homeCubit;
  final ChatsCubit _chatsCubit;
  SearchCubit({
    required HomeCubit homeCubit,
    required ChatsCubit chatsCubit,
  })  : _homeCubit = homeCubit,
        _chatsCubit = chatsCubit,
        super(const SearchState.initial());

  TextEditingController? searchController;
  List<UserData> searchResult = [];
  void initSearch() {
    searchController = TextEditingController();
    emit(const SearchState.initControllers());
  }

  void disposeSearch() {
    searchController!.dispose();
    searchResult = [];
    emit(const SearchState.disposeControllers());
  }

  void onChangeSearchTextField({required String value}) {
    List<UserData> nameResult = _homeCubit.users.where((element) {
      return element.name!.toLowerCase().contains(value.toLowerCase());
    }).toList();

    List<UserData> contactsPhoneResult = _homeCubit.users.where((element) {
      return element.phone!.toLowerCase().contains(value.toLowerCase());
    }).toList();

    final chats = _chatsCubit.chats.where((chat) {
      return chat.user!.phone!.toLowerCase().contains(value.toLowerCase());
    }).toList();
    List<UserData> chatsResult = [];
    if (chats.isNotEmpty) {
      for (ChatsModel chat in chats) {
        chatsResult.add(chat.user!);
      }
    }

    searchResult =
        (nameResult + contactsPhoneResult + chatsResult).toSet().toList();

    searchResult.sort(
      (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
    );

    emit(SearchState.onChangeSearchTextField(value));
  }

  void clearSearchTextField() {
    searchController!.clear();
    searchResult = [];
    emit(const SearchState.clearSearchTextField());
  }
}
