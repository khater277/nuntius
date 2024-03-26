import 'package:nuntius/core/errors/api/network_exceptions.dart';
import 'package:nuntius/core/errors/firebase/auth/auth_exceptions.dart';
import 'package:nuntius/core/errors/firebase/firestore/firestore_exceptions.dart';
import 'package:nuntius/core/errors/firebase/storage/storage_exceptions.dart';

enum NetworkErrorTypes { noInternetConnection, api, auth, firestore, storage }

abstract class Failure {
  String getMessage();
  Exception getException();
}

class NoInternetConnection implements Exception {}

class FailureBody {
  final String message;
  final Exception exception;

  FailureBody({required this.message, required this.exception});
}

class ServerFailure extends Failure {
  final Exception error;
  final NetworkErrorTypes type;

  ServerFailure({
    required this.error,
    required this.type,
  });

  FailureBody handleException(e) {
    FailureBody result;
    switch (type) {
      case NetworkErrorTypes.noInternetConnection:
        result = FailureBody(
          message:
              "There is no internet connection, please check your connection and try again later.",
          exception: NoInternetConnection(),
        );
        break;
      case NetworkErrorTypes.api:
        result = FailureBody(
          message: NetworkExceptions.getErrorMessage(
              NetworkExceptions.getDioException(error)),
          exception: NetworkExceptions.getDioException(error),
        );
        break;
      case NetworkErrorTypes.auth:
        result = FailureBody(
          message: AuthExceptionHandler.generateExceptionMessage(
              AuthExceptionHandler.handleException(error)),
          exception: AuthExceptionHandler.handleException(error),
        );
        break;
      case NetworkErrorTypes.firestore:
        result = FailureBody(
          message: FirestoreExceptionHandler.generateExceptionMessage(
              FirestoreExceptionHandler.handleException(error)),
          exception: FirestoreExceptionHandler.handleException(error),
        );
        break;
      case NetworkErrorTypes.storage:
        result = FailureBody(
          message: StorageExceptionHandler.generateExceptionMessage(
              StorageExceptionHandler.handleException(error)),
          exception: StorageExceptionHandler.handleException(error),
        );
        break;
      default:
        result = e;
    }
    return result;
  }

  @override
  String getMessage() => handleException(error).message;

  @override
  Exception getException() => handleException(error).exception;
}
