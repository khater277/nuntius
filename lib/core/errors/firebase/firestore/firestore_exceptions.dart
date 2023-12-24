import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_exceptions.freezed.dart';

@freezed
class FirestoreExceptionHandler
    with _$FirestoreExceptionHandler
    implements Exception {
  const factory FirestoreExceptionHandler.aborted() = Aborted;
  const factory FirestoreExceptionHandler.alreadyExists() = AlreadyExists;
  const factory FirestoreExceptionHandler.cancelled() = Cancelled;
  const factory FirestoreExceptionHandler.dataLoss() = DataLoss;
  const factory FirestoreExceptionHandler.deadLineExceeded() = DeadLineExceeded;
  const factory FirestoreExceptionHandler.failedPrecondition() =
      FailedPrecondition;
  const factory FirestoreExceptionHandler.internal() = Internal;
  const factory FirestoreExceptionHandler.invalidArgument() = InvalidArgument;
  const factory FirestoreExceptionHandler.notFound() = NotFound;
  const factory FirestoreExceptionHandler.ok() = Ok;
  const factory FirestoreExceptionHandler.outOfRange() = OutOfRange;
  const factory FirestoreExceptionHandler.permissionDenied() = PermissionDenied;
  const factory FirestoreExceptionHandler.resourceExhausted() =
      ResourceExhausted;

  const factory FirestoreExceptionHandler.unauthenticated() = Unauthenticated;
  const factory FirestoreExceptionHandler.unavailable() = Unavailable;
  const factory FirestoreExceptionHandler.unimplemented() = Unimplemented;
  const factory FirestoreExceptionHandler.unknown() = Unknown;
  const factory FirestoreExceptionHandler.undefined() = Undefined;
  const factory FirestoreExceptionHandler.timeout() = Timeout;

  static FirestoreExceptionHandler handleException(e) {
    FirestoreExceptionHandler status;

    switch (e.code) {
      case "aborted":
        status = const FirestoreExceptionHandler.aborted();
        break;
      case "already-exists":
        status = const FirestoreExceptionHandler.alreadyExists();
        break;
      case "cancelled":
        status = const FirestoreExceptionHandler.cancelled();
        break;
      case "data-loss":
        status = const FirestoreExceptionHandler.dataLoss();
        break;
      case "deadline-exceeded":
        status = const FirestoreExceptionHandler.deadLineExceeded();
        break;
      case "failed-precondition":
        status = const FirestoreExceptionHandler.failedPrecondition();
        break;
      case "internal":
        status = const FirestoreExceptionHandler.internal();
        break;
      case "invalid-argument":
        status = const FirestoreExceptionHandler.invalidArgument();
        break;
      case "not-found":
        status = const FirestoreExceptionHandler.notFound();
        break;
      case "ok":
        status = const FirestoreExceptionHandler.ok();
        break;
      case "out-of-range":
        status = const FirestoreExceptionHandler.outOfRange();
        break;
      case "permission-denied":
        status = const FirestoreExceptionHandler.permissionDenied();
        break;
      case "resource-exhausted":
        status = const FirestoreExceptionHandler.resourceExhausted();
        break;
      case "unauthenticated":
        status = const FirestoreExceptionHandler.unauthenticated();
        break;
      case "unavailable":
        status = const FirestoreExceptionHandler.unavailable();
        break;
      case "unimplemented":
        status = const FirestoreExceptionHandler.unimplemented();
        break;
      case "unknown":
        status = const FirestoreExceptionHandler.unknown();
        break;
      case "timeout":
        status = const FirestoreExceptionHandler.timeout();
        break;
      default:
        status = const FirestoreExceptionHandler.undefined();
    }

    return status;
  }

  static String generateExceptionMessage(
      FirestoreExceptionHandler firestoreExceptionHandler) {
    String errorMessage = "";

    firestoreExceptionHandler.when(
      aborted: () => errorMessage =
          "The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.",
      alreadyExists: () => errorMessage = "Already exists.",
      cancelled: () => errorMessage =
          "The operation was cancelled (typically by the caller).",
      dataLoss: () => errorMessage = "Unrecoverable data loss or corruption.",
      deadLineExceeded: () =>
          errorMessage = "Deadline expired before operation could complete.",
      failedPrecondition: () => errorMessage =
          "Operation was rejected because the system is not in a state required for the operation's execution.",
      internal: () => errorMessage = "Internal errors.",
      invalidArgument: () =>
          errorMessage = "Client specified an invalid argument.",
      notFound: () => errorMessage = "Some requested document was not found.",
      ok: () => errorMessage = "The operation completed successfully.",
      outOfRange: () =>
          errorMessage = "Operation was attempted past the valid range.",
      permissionDenied: () => errorMessage =
          "The caller does not have permission to execute the specified operation.",
      resourceExhausted: () => errorMessage =
          "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.",
      unauthenticated: () => errorMessage =
          "The request does not have valid authentication credentials for the operation.",
      unavailable: () => errorMessage = "The service is currently unavailable.",
      unimplemented: () => errorMessage =
          "Operation is not implemented or not supported/enabled.",
      unknown: () => errorMessage =
          "Unknown error or an error from a different error domain.",
      timeout: () => errorMessage = "Request Timeout.",
      undefined: () => errorMessage = "Undefined error occurs",
    );
    return errorMessage;
  }
}
