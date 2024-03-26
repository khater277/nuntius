// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius/core/local_storage/all_users_storage.dart';
import 'package:nuntius/core/local_storage/calls_storage.dart';
import 'package:nuntius/core/local_storage/chats_storage.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/auth/data/models/all_users/all_users_model.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/auth/domain/usecases/add_user_to_firestore_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/get_all_users_from_firestore_usecase.dart';
import 'package:nuntius/features/calls/presentation/screens/calls_screen.dart';
import 'package:nuntius/features/chats/presentation/screen/chats_screen.dart';
import 'package:nuntius/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:nuntius/features/messages/domain/usecases/get_user_stream_usecase.dart';
import 'package:nuntius/features/stories/presentation/screens/stories_screen.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserStorage _userStorage;
  final AllUsersStorage _allUsersStorage;
  final ChatsStorage _chatsStorage;
  final CallsStorage _callsStorage;
  final AddUserToFirestoreUsecase _addUserToFirestoreUsecase;
  final GetAllUsersFromFirestoreUsecase _getAllUsersFromFirestoreUsecase;
  final GetUserStreamUsecase _getUserStreamUsecase;

  HomeCubit({
    required UserStorage userStorage,
    required AllUsersStorage allUsersStorage,
    required ChatsStorage chatsStorage,
    required CallsStorage callsStorage,
    required AddUserToFirestoreUsecase addUserToFirestoreUsecase,
    required GetAllUsersFromFirestoreUsecase getAllUsersFromFirestoreUsecase,
    required GetUserStreamUsecase getUserStreamUsecase,
  })  : _userStorage = userStorage,
        _allUsersStorage = allUsersStorage,
        _chatsStorage = chatsStorage,
        _callsStorage = callsStorage,
        _addUserToFirestoreUsecase = addUserToFirestoreUsecase,
        _getAllUsersFromFirestoreUsecase = getAllUsersFromFirestoreUsecase,
        _getUserStreamUsecase = getUserStreamUsecase,
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
  UserData? myData;
  bool reAuthChats = false;

  // void resetAuthValues(){
  //   r
  // }

  void listenToMyData() async {
    final response =
        await _getUserStreamUsecase.call(_userStorage.getUser()!.phone!);
    response.fold(
      (failure) {
        myData = _userStorage.getUser()!;
        emit(HomeState.listenToMyData(myData));
      },
      (stream) async {
        if (await stream.isEmpty == false) {
          stream.listen((event) async {
            if (event.data() != null) {
              myData = UserData.fromJson(event.data()!);
              if (_userStorage.getUser() != null &&
                  _userStorage.getUser()!.token != myData!.token) {
                reAuthChats = true;
                _userStorage.saveUser(user: null);
                _chatsStorage.deleteAll();
                _callsStorage.deleteAll();
                emit(HomeState.listenToMyData(myData));
              }
            } else {
              emit(const HomeState.listenToMyData(null));
            }
          });
        }
      },
    );
  }

  Future<void> getContacts({bool? isAddContact}) async {
    if (isAddContact != true) {
      users = [];
      contacts = [];
      phones = {};
      emit(const HomeState.getContactsLoading());
    }

    try {
      contacts = await ContactsService.getContacts(withThumbnails: false);
      await _handleContacts();
      await _handleUsers();
      final response = await _addUserToFirestoreUsecase
          .call(_userStorage.getUser()!.copyWith(contacts: phones));
      response.fold(
        (failure) {
          debugPrint("==========>${failure.getMessage()}");
          emit(const HomeState.getContactsError());
        },
        (result) => emit(const HomeState.getContacts()),
      );
      debugPrint("=================>$phones");
      debugPrint(contacts.length.toString());
    } catch (error) {
      users = _allUsersStorage.hasData()
          ? _allUsersStorage.getAllUsers()!.users ?? []
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
            ? _allUsersStorage.getAllUsers()!.users ?? []
            : [];
        users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );
        debugPrint("asd=======>${users.first.name}");
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
                    _userStorage.getUser()!.phone)) {
              users.add(user.copyWith(name: contacts[i].displayName));
              phones[contacts[i].phones!.first.value!] =
                  contacts[i].displayName!;
            }
          }
        }
        users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );
        await _allUsersStorage.saveAllUsers(
            allUsers: AllUsersModel(users: users));
      },
    );
  }
}
