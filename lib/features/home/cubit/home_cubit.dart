// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius_/core/local_storage/all_users_storage.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/features/auth/data/models/all_users/all_users_model.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius_/features/auth/domain/usecases/add_user_to_firestore_usecase.dart';
import 'package:nuntius_/features/auth/domain/usecases/get_all_users_from_firestore_usecase.dart';
import 'package:nuntius_/features/calls/presentation/screens/calls_screen.dart';
import 'package:nuntius_/features/chats/presentation/screen/chats_screen.dart';
import 'package:nuntius_/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:nuntius_/features/stories/presentation/screens/stories_screen.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserStorage _userStorage;
  final AllUsersStorage _allUsersStorage;
  final AddUserToFirestoreUsecase _addUserToFirestoreUsecase;
  final GetAllUsersFromFirestoreUsecase _getAllUsersFromFirestoreUsecase;

  HomeCubit({
    required UserStorage userStorage,
    required AllUsersStorage allUsersStorage,
    required AddUserToFirestoreUsecase addUserToFirestoreUsecase,
    required GetAllUsersFromFirestoreUsecase getAllUsersFromFirestoreUsecase,
  })  : _userStorage = userStorage,
        _allUsersStorage = allUsersStorage,
        _addUserToFirestoreUsecase = addUserToFirestoreUsecase,
        _getAllUsersFromFirestoreUsecase = getAllUsersFromFirestoreUsecase,
        super(const HomeState.initial());
  static HomeCubit get(context) => BlocProvider.of(context);

  // bottom navigation bar screens
  List<Widget> screens = [
    const ChatsScreen(),
    const StoriesScreen(),
    const CallsScreen(),
    const ContactsScreen()
  ];

  void changeNavBar({required int index}) {
    emit(HomeState.changeNavBar(index));
  }

  List<Contact> contacts = [];
  List<UserData> users = [];
  Map<String, String> phones = {};
  // UserData? user;

  // void initUser({required UserData user}) {
  //   this.user = user;
  //   emit(const HomeState.initUser());
  // }

  // void disposeUser() {
  //   user = null;
  //   emit(const HomeState.disposeUser());
  // }

  Future<void> getContacts({bool? isAddContact}) async {
    if (isAddContact != true) emit(const HomeState.getContactsLoading());
    try {
      contacts = await ContactsService.getContacts(withThumbnails: false);
      await _handleContacts();
      await _handleUsers();
      final response = await _addUserToFirestoreUsecase
          .call(_userStorage.getData()!.copyWith(contacts: phones));
      response.fold(
        (failure) {
          print("==========>${failure.getMessage()}");
          emit(const HomeState.getContactsError());
        },
        (result) => emit(const HomeState.getContacts()),
      );
      print("=================>${phones}");
      print(contacts.length);
    } catch (error) {
      users = _allUsersStorage.hasData()
          ? _allUsersStorage.getData()!.users ?? []
          : [];
      emit(const HomeState.getContactsError());
    }
  }

  Future<void> _handleContacts() async {
    for (int i = 0; i < contacts.length; i++) {
      final oldContact = contacts[i];
      if (oldContact.phones!.isNotEmpty) {
        if (!oldContact.phones!.first.value!.startsWith('+2')) {
          final Contact newContact = Contact(
            displayName: oldContact.displayName,
            emails: oldContact.emails,
            company: oldContact.company,
            phones: [
              Item(
                label: oldContact.phones![0].label,
                value: "+2${oldContact.phones![0].value!.replaceAll(' ', '')}",
              )
            ],
          );
          contacts[i] = newContact;
        }
      }
    }
  }

  Future<void> _handleUsers() async {
    final response = await _getAllUsersFromFirestoreUsecase.call(NoParams());
    response.fold(
      (failure) {
        users = _allUsersStorage.hasData()
            ? _allUsersStorage.getData()!.users ?? []
            : [];
        users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );
        print("asd=======>${users.first.name}");
      },
      (usersData) async {
        for (int i = 0; i < contacts.length; i++) {
          final user = usersData.firstWhereOrNull((element) =>
              contacts[i].phones!.isNotEmpty
                  ? element.phone == contacts[i].phones!.first.value
                  : false);
          if (user != null) {
            final existedUser = users
                .firstWhereOrNull((element) => element.phone == user.phone);
            if (existedUser == null &&
                (contacts[i].phones!.first.value != null) &&
                (contacts[i].phones!.first.value !=
                    _userStorage.getData()!.phone)) {
              users.add(user.copyWith(name: contacts[i].displayName));
              phones[contacts[i].phones!.first.value!] =
                  contacts[i].displayName!;
            }
          }
        }
        users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );
        await _allUsersStorage.saveData(data: AllUsersModel(users: users));
      },
    );
  }
}
