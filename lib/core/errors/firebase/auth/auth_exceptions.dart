import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_exceptions.freezed.dart';

@freezed
class AuthExceptionHandler with _$AuthExceptionHandler implements Exception {
  const factory AuthExceptionHandler.wrongPassword() = WrongPassword;
  const factory AuthExceptionHandler.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthExceptionHandler.weakPassword() = WeakPassword;
  const factory AuthExceptionHandler.invalidEmail() = InvalidEmail;
  const factory AuthExceptionHandler.userNotFound() = UserNotFound;
  const factory AuthExceptionHandler.userDisabled() = UserDisabled;
  const factory AuthExceptionHandler.operationNotAllowed() =
      OperationNotAllowed;
  const factory AuthExceptionHandler.expiredActionCode() = ExpiredActionCode;
  const factory AuthExceptionHandler.networkRequestFailed() =
      NetworkRequestFailed;
  const factory AuthExceptionHandler.tooManyRequests() = TooManyRequests;
  const factory AuthExceptionHandler.requestCancelled() = RequestCancelled;
  const factory AuthExceptionHandler.emailExistsWithDifferentCredential() =
      EmailExistsWithDifferentCredential;
  const factory AuthExceptionHandler.timeout() = Timeout;
  const factory AuthExceptionHandler.undefined() = Undefined;

  static AuthExceptionHandler handleException(e) {
    AuthExceptionHandler status;

    switch (e.code) {
      case "invalid-email":
        status = const AuthExceptionHandler.invalidEmail();
        break;
      case "wrong-password":
        status = const AuthExceptionHandler.wrongPassword();
        break;
      case "weak-password":
        status = const AuthExceptionHandler.weakPassword();
        break;
      case "user-not-found":
        status = const AuthExceptionHandler.userNotFound();
        break;
      case "user-disabled":
        status = const AuthExceptionHandler.userDisabled();
        break;
      case "too-many-requests":
        status = const AuthExceptionHandler.tooManyRequests();
        break;
      case "operation-not-allowed":
        status = const AuthExceptionHandler.operationNotAllowed();
        break;
      case "email-already-in-use":
        status = const AuthExceptionHandler.emailAlreadyInUse();
        break;
      case "expired-action-code":
        status = const AuthExceptionHandler.expiredActionCode();
        break;
      case "network-request-failed":
        status = const AuthExceptionHandler.networkRequestFailed();
        break;
      case "request-cancelled":
        status = const AuthExceptionHandler.requestCancelled();
        break;
      case "account-exists-with-different-credential":
        status = const AuthExceptionHandler.requestCancelled();
        break;
      case "timeout":
        status = const AuthExceptionHandler.requestCancelled();
        break;
      default:
        status = const AuthExceptionHandler.undefined();
    }

    return status;
  }

  static String generateExceptionMessage(
      AuthExceptionHandler authExceptionHandler) {
    String errorMessage = "";

    authExceptionHandler.when(
      wrongPassword: () => errorMessage = "Your password is wrong.",
      emailAlreadyInUse: () => errorMessage =
          "The email has already been registered. Please login or reset your password.",
      weakPassword: () => errorMessage = "The password is weak.",
      invalidEmail: () =>
          errorMessage = "Your email address appears to be malformed.",
      userNotFound: () => errorMessage = "User with this email doesn't exist.",
      userDisabled: () =>
          errorMessage = "User with this email has been disabled.",
      operationNotAllowed: () =>
          errorMessage = "Signing in with Email and Password is not enabled.",
      expiredActionCode: () =>
          errorMessage = "The code you try to submit has been expired.",
      networkRequestFailed: () => errorMessage = "Network request failed.",
      tooManyRequests: () =>
          errorMessage = "Too many requests. Try again later.",
      undefined: () => "Undefined Error",
      requestCancelled: () => errorMessage = "Your request has been cancelled.",
      emailExistsWithDifferentCredential: () => errorMessage =
          "The account already exists with a different credential.",
      timeout: () => errorMessage = "Request timeout.",
    );
    return errorMessage;
  }
}
