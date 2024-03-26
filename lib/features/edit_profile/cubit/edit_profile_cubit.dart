import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/calls_storage.dart';
import 'package:nuntius/core/local_storage/chats_storage.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius/features/auth/domain/usecases/upload_file_to_storage_usecase.dart';
import 'package:nuntius/features/edit_profile/domain/usecases/delete_account_usecase.dart';
import 'package:nuntius/features/edit_profile/domain/usecases/update_profile_data_usecase.dart';

part 'edit_profile_cubit.freezed.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateProfileDataUsecase _updateProfileDataUsecase;
  final UploadFileToStorageUsecase _uploadFileToStorageUsecase;
  final DeleteAccountUsecase _deleteAccountUsecase;
  final UserStorage _userStorage;
  final ChatsStorage _chatsStorage;
  final CallsStorage _callsStorage;

  EditProfileCubit({
    required UpdateProfileDataUsecase updateProfileDataUsecase,
    required UploadFileToStorageUsecase uploadFileToStorageUsecase,
    required DeleteAccountUsecase deleteAccountUsecase,
    required UserStorage userStorage,
    required ChatsStorage chatsStorage,
    required CallsStorage callsStorage,
  })  : _updateProfileDataUsecase = updateProfileDataUsecase,
        _uploadFileToStorageUsecase = uploadFileToStorageUsecase,
        _deleteAccountUsecase = deleteAccountUsecase,
        _userStorage = userStorage,
        _chatsStorage = chatsStorage,
        _callsStorage = callsStorage,
        super(const EditProfileState.initial());

  ImagePicker picker = ImagePicker();
  File? profileImage;
  double? profileImagePercentage;
  TextEditingController nameController = TextEditingController();

  void initEditProfileScreen() {
    nameController = TextEditingController(text: _userStorage.getUser()!.name!);
    emit(const EditProfileState.initEditProfileScreen());
  }

  void disposeEditProfileScreen() {
    profileImage = null;
    profileImagePercentage = null;
    nameController.dispose();
    emit(const EditProfileState.disposeEditProfileScreen());
  }

  Future<void> pickProfileImage() async {
    emit(const EditProfileState.pickProfileImageLoading());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(const EditProfileState.pickProfileImage());
    } else {
      debugPrint("NOT SELECTED");

      emit(const EditProfileState.pickProfileImageError("NOT SELECTED"));
    }
  }

  void uploadProfileImage() async {
    emit(const EditProfileState.updateProfileImageLoading());
    final response = await _uploadFileToStorageUsecase.call(
        UploadFileToStorageParams(
            collectionName: Collections.profileImages, file: profileImage!));
    response.fold(
      (failure) {
        emit(EditProfileState.updateProfileImageError(failure.getMessage()));
      },
      (result) {
        result!.fold(
          (url) => updateProfileImage(image: url),
          (taskSnapshot) {
            taskSnapshot.listen((event) async {
              switch (event.state) {
                case TaskState.running:
                  profileImagePercentage =
                      event.bytesTransferred / event.totalBytes;
                  debugPrint("===============> $profileImagePercentage");
                  emit(EditProfileState.getProfileImagePercentage(
                      profileImagePercentage));
                  break;
                case TaskState.paused:
                  break;
                case TaskState.success:
                  updateProfileImage(image: await event.ref.getDownloadURL());
                  break;
                case TaskState.canceled:
                  emit(const EditProfileState.updateProfileImageError(
                      "The operation has been cancelled."));
                  break;
                case TaskState.error:
                  emit(const EditProfileState.updateProfileImageError(
                      "The operation has been failed."));
                  break;
              }
            });
          },
        );
      },
    );
  }

  void updateProfileImage({required String image}) async {
    final response = await _updateProfileDataUsecase.call({"image": image});
    response.fold(
      (failure) =>
          emit(EditProfileState.updateProfileImageError(failure.getMessage())),
      (result) {
        profileImage = null;
        profileImagePercentage = null;
        _userStorage.saveUser(
            user: _userStorage.getUser()!.copyWith(image: image));
        emit(const EditProfileState.updateProfileImage());
      },
    );
  }

  void updateProfileName() async {
    if (nameController.text != _userStorage.getUser()!.name) {
      emit(const EditProfileState.updateProfileNameLoading());
      final response =
          await _updateProfileDataUsecase.call({"name": nameController.text});
      response.fold(
        (failure) =>
            emit(EditProfileState.updateProfileNameError(failure.getMessage())),
        (result) {
          _userStorage.saveUser(
              user:
                  _userStorage.getUser()!.copyWith(name: nameController.text));
          emit(const EditProfileState.updateProfileName());
        },
      );
    }
  }

  void deleteAccount() async {
    emit(const EditProfileState.deleteAccountLoading());
    final response = await _deleteAccountUsecase.call(NoParams());
    response.fold(
      (failure) =>
          emit(EditProfileState.deleteAccountError(failure.getMessage())),
      (result) async {
        await _userStorage.saveUser(user: null);
        await _chatsStorage.deleteAll();
        await _callsStorage.deleteAll();
        emit(const EditProfileState.deleteAccount());
      },
    );
  }
}
