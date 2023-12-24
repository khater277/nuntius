part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.initController() = _InitController;
  const factory AuthState.disposeController() = _DisposeController;
  const factory AuthState.signInWithPhoneNumberLoading() =
      _SignInWithPhoneNumberLoading;
  const factory AuthState.codeSent() = _CodeSent;
  const factory AuthState.submitOtpLoading() = _SubmitOtpLoading;
  const factory AuthState.submitOtp() = _SubmitOtp;
  const factory AuthState.verificationCompleted() = _VerificationCompleted;
  const factory AuthState.errorState(String errorMsg) = _ErrorState;
  const factory AuthState.pickProfileImageLoading() = _PickProfileImageLoading;
  const factory AuthState.pickProfileImage() = _PickProfileImage;
  const factory AuthState.pickProfileImageError(String errorMsg) =
      _PickProfileImageError;
  const factory AuthState.uploadImageToStorageLoading() =
      _UploadImageToStorageLoading;
  const factory AuthState.uploadImageToStorage() = _UploadImageToStorage;
  const factory AuthState.uploadImageToStorageError(String errorMsg) =
      _UploadImageToStorageError;

  const factory AuthState.addUserToFirestoreLoading() =
      _AddUserToFirestoreLoading;
  const factory AuthState.addUserToFirestore() = _AddUserToFirestore;
  const factory AuthState.addUserToFirestoreError(String errorMsg) =
      _AddUserToFirestoreError;

  const factory AuthState.updateUserTokenLoading() = _UpdateUserTokenLoading;
  const factory AuthState.updateUserToken() = _UpdateUserToken;
  const factory AuthState.updateUserTokenError(String errorMsg) =
      _UpdateUserTokenError;

  const factory AuthState.getContactsLoading() = _GetContactsLoading;
  const factory AuthState.getContacts() = _GetContacts;
  const factory AuthState.getContactsError(String errorMsg) = _GetContactsError;
}
