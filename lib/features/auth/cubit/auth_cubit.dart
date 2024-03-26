import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/all_users_storage.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius/features/auth/data/models/all_users/all_users_model.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/auth/domain/parameters/sign_in_with_phone_number_params.dart';
import 'package:nuntius/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius/features/auth/domain/parameters/verify_phone_number_params.dart';
import 'package:nuntius/features/auth/domain/usecases/add_user_to_firestore_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/get_all_users_from_firestore_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/update_user_token_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/upload_file_to_storage_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/verify_phone_number_usecase.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserStorage _userStorage;
  final AllUsersStorage _allUsersStorage;
  final VerifyPhoneNumberUsecase _verifyPhoneNumberUsecase;
  final SignInWithPhoneNumberUsecase _signInWithPhoneNumberUsecase;
  final AddUserToFirestoreUsecase _addUserToFirestoreUsecase;
  final GetAllUsersFromFirestoreUsecase _getAllUsersFromFirestoreUsecase;
  final UpdateUserTokenUsecase _updateUserTokenUsecase;
  final UploadFileToStorageUsecase _uploadFileToStorageUsecase;

  AuthCubit({
    required UserStorage userStorage,
    required AllUsersStorage allUsersStorage,
    required VerifyPhoneNumberUsecase verifyPhoneNumberUsecase,
    required SignInWithPhoneNumberUsecase signInWithPhoneNumberUsecase,
    required AddUserToFirestoreUsecase addUserToFirestoreUsecase,
    required GetAllUsersFromFirestoreUsecase getAllUsersFromFirestoreUsecase,
    required UpdateUserTokenUsecase updateUserTokenUsecase,
    required UploadFileToStorageUsecase uploadFileToStorageUsecase,
  })  : _userStorage = userStorage,
        _allUsersStorage = allUsersStorage,
        _verifyPhoneNumberUsecase = verifyPhoneNumberUsecase,
        _signInWithPhoneNumberUsecase = signInWithPhoneNumberUsecase,
        _addUserToFirestoreUsecase = addUserToFirestoreUsecase,
        _getAllUsersFromFirestoreUsecase = getAllUsersFromFirestoreUsecase,
        _updateUserTokenUsecase = updateUserTokenUsecase,
        _uploadFileToStorageUsecase = uploadFileToStorageUsecase,
        super(const AuthState.initial());

  TextEditingController? phoneController;
  TextEditingController? nameController;

  void initPhoneController() {
    phoneController = TextEditingController();
    emit(const AuthState.initController());
  }

  void disposePhoneController() {
    phoneController!.dispose();
    emit(const AuthState.disposeController());
  }

  void initNameController() {
    bool condition =
        _userStorage.getUser() != null && _userStorage.getUser()!.name != "";
    nameController = TextEditingController(
        text: condition ? _userStorage.getUser()!.name : null);
    emit(const AuthState.initController());
  }

  void disposeNameController() {
    nameController!.dispose();
    emit(const AuthState.disposeController());
  }

  late String id;
  void signInWithPhoneNumber({String? phoneNumber}) async {
    emit(const AuthState.signInWithPhoneNumberLoading());
    final response =
        await _verifyPhoneNumberUsecase.call(VerifyPhoneNumberParams(
      phoneNumber: phoneNumber ?? phoneController!.text,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
    ));

    response.fold(
      (failure) => emit(AuthState.errorState(failure.getMessage())),
      (result) {},
    );
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(const AuthState.verificationCompleted());
    } on FirebaseAuthException catch (error) {
      emit(AuthState.errorState("${error.message}"));
    }
  }

  void _verificationFailed(FirebaseAuthException error) {
    emit(AuthState.errorState("${error.message}"));
  }

  void _codeSent(String verificationId, int? resendToken) {
    id = verificationId;
    emit(const AuthState.codeSent());
  }

  void submitOtp(String smsCode) async {
    emit(const AuthState.submitOtpLoading());
    final response =
        await _signInWithPhoneNumberUsecase.call(SignInWithPhoneNumberParams(
      verificationId: id,
      smsCode: smsCode,
    ));

    response.fold(
      (failure) => emit(AuthState.errorState(failure.getMessage())),
      (userCredential) => emit(const AuthState.submitOtp()),
    );
  }

  ImagePicker picker = ImagePicker();
  File? profileImage;
  double? profileImagePercentage;

  Future<void> pickProfileImage() async {
    emit(const AuthState.pickProfileImageLoading());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(const AuthState.pickProfileImage());
    } else {
      debugPrint("NOT SELECTED");
      emit(const AuthState.pickProfileImageError("NOT SELECTED"));
    }
  }

  void uploadImageToStorage() async {
    emit(const AuthState.uploadImageToStorageLoading());
    final response =
        await _uploadFileToStorageUsecase.call(UploadFileToStorageParams(
      collectionName: Collections.profileImages,
      file: profileImage!,
    ));
    response.fold(
      (failure) {
        emit(AuthState.uploadImageToStorageError(failure.getMessage()));
      },
      (result) {
        result!.fold(
          (url) {
            addUserToFirestore(image: url);
          },
          (taskSnapshot) {
            taskSnapshot.listen((event) async {
              switch (event.state) {
                case TaskState.running:
                  profileImagePercentage =
                      event.bytesTransferred / event.totalBytes;
                  debugPrint("===============> $profileImagePercentage");
                  emit(const AuthState.uploadImageToStorageLoading());
                  break;
                case TaskState.paused:
                  break;
                case TaskState.success:
                  addUserToFirestore(image: await event.ref.getDownloadURL());
                  break;
                case TaskState.canceled:
                  emit(const AuthState.uploadImageToStorageError(
                      "The operation has been cancelled."));
                  break;
                case TaskState.error:
                  emit(const AuthState.uploadImageToStorageError(
                      "The operation has been failed."));
                  break;
              }
            });
          },
        );
      },
    );
  }

  List<Contact> contacts = [];
  List<UserData> users = [];
  Map<String, String> phones = {};
  void addUserToFirestore({
    String? image,
  }) async {
    bool condition = image == null;
    if (condition) emit(const AuthState.addUserToFirestoreLoading());
    try {
      contacts = await ContactsService.getContacts(withThumbnails: false);
      await _handleContacts();
      await _handleUsers();
      final token = await FirebaseMessaging.instance.getToken();
      UserData user = UserData(
        token: token,
        name: nameController!.text.isNotEmpty ? nameController!.text : 'user',
        uId: await SharedPrefHelper.getUid(),
        phone: "+2${phoneController!.text}",
        image: image ??
            (_userStorage.getUser() != null
                ? _userStorage.getUser()!.image
                : ""),
        inCall: false,
        contacts: phones,
      );
      final response = await _addUserToFirestoreUsecase.call(user);
      response.fold(
        (failure) {
          emit(AuthState.addUserToFirestoreError(failure.getMessage()));
        },
        (result) async {
          await _userStorage.saveUser(user: user);
          emit(const AuthState.addUserToFirestore());
        },
      );
    } catch (error) {
      debugPrint("===========>${error.toString()}");
      emit(const AuthState.addUserToFirestoreError(
          'unable to complete the process , something went wrong'));
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
        if (users.isNotEmpty) {
          users.sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
          );
        }
      },
      (usersData) {
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
                    "+2${phoneController!.text}")) {
              users.add(user.copyWith(name: contacts[i].displayName));
              phones[contacts[i].phones!.first.value!] =
                  contacts[i].displayName!;
            }
          }
        }
        _allUsersStorage.saveAllUsers(allUsers: AllUsersModel(users: users));
        if (users.isNotEmpty) {
          users.sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
          );
        }
      },
    );
  }

  void updateUserToken() async {
    emit(const AuthState.updateUserTokenLoading());
    final token = await FirebaseMessaging.instance.getToken();
    final response = await _updateUserTokenUsecase.call(token!);
    response.fold(
      (failure) {
        emit(AuthState.updateUserTokenError(failure.getMessage()));
      },
      (result) async {
        _userStorage.saveUser(
            user: _userStorage.getUser()!.copyWith(token: token));
        emit(const AuthState.updateUserToken());
      },
    );
  }
}
