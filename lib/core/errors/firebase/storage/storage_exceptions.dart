import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_exceptions.freezed.dart';

@freezed
class StorageExceptionHandler
    with _$StorageExceptionHandler
    implements Exception {
  const factory StorageExceptionHandler.unknown() = Unknown;
  const factory StorageExceptionHandler.objectNotFound() = ObjectNotFound;

  const factory StorageExceptionHandler.bucketNotFound() = BucketNotFound;
  const factory StorageExceptionHandler.projectNotFound() = ProjectNotFound;
  const factory StorageExceptionHandler.quotaExceeded() = QuotaExceeded;
  const factory StorageExceptionHandler.unauthenticated() = Unauthenticated;
  const factory StorageExceptionHandler.unauthorized() = Unauthorized;
  const factory StorageExceptionHandler.retryLimitExceeded() =
      RetryLimitExceeded;
  const factory StorageExceptionHandler.invalidChecksum() = InvalidChecksum;
  const factory StorageExceptionHandler.cancelled() = Cancelled;
  const factory StorageExceptionHandler.invalidEventName() = InvalidEventName;
  const factory StorageExceptionHandler.invalidUrl() = InvalidUrl;
  const factory StorageExceptionHandler.invalidArgument() = InvalidArgument;
  const factory StorageExceptionHandler.noDefaultBucket() = NoDefaultBucket;
  const factory StorageExceptionHandler.cannotSliceBlob() = CannotSliceBlob;
  const factory StorageExceptionHandler.serverFileWrongSize() =
      ServerFileWrongSize;
  const factory StorageExceptionHandler.timeout() = Timeout;
  static StorageExceptionHandler handleException(e) {
    StorageExceptionHandler status;

    switch (e.code) {
      case "storage/unknown":
        status = const StorageExceptionHandler.unknown();
        break;
      case "storage/object-not-found":
        status = const StorageExceptionHandler.objectNotFound();
        break;
      case "storage/bucket-not-found":
        status = const StorageExceptionHandler.bucketNotFound();
        break;
      case "storage/project-not-found":
        status = const StorageExceptionHandler.projectNotFound();
        break;
      case "storage/quota-exceeded":
        status = const StorageExceptionHandler.quotaExceeded();
        break;
      case "storage/unauthenticated":
        status = const StorageExceptionHandler.unauthenticated();
        break;
      case "storage/unauthorized":
        status = const StorageExceptionHandler.unauthorized();
        break;
      case "storage/retry-limit-exceeded":
        status = const StorageExceptionHandler.retryLimitExceeded();
        break;
      case "storage/invalid-checksum":
        status = const StorageExceptionHandler.invalidChecksum();
        break;
      case "storage/canceled":
        status = const StorageExceptionHandler.cancelled();
        break;
      case "storage/invalid-event-name":
        status = const StorageExceptionHandler.invalidEventName();
        break;
      case "storage/invalid-url":
        status = const StorageExceptionHandler.invalidUrl();
        break;
      case "storage/invalid-argument":
        status = const StorageExceptionHandler.invalidArgument();
        break;
      case "storage/no-default-bucket":
        status = const StorageExceptionHandler.noDefaultBucket();
        break;
      case "storage/cannot-slice-blob":
        status = const StorageExceptionHandler.cannotSliceBlob();
        break;
      case "storage/server-file-wrong-size":
        status = const StorageExceptionHandler.serverFileWrongSize();
        break;
      case "timeout":
        status = const StorageExceptionHandler.timeout();
        break;
      default:
        status = const StorageExceptionHandler.unknown();
    }

    return status;
  }

  static String generateExceptionMessage(
      StorageExceptionHandler storageExceptionHandler) {
    String errorMessage = "";

    storageExceptionHandler.when(
      unknown: () => errorMessage = "An unknown error occurred.",
      objectNotFound: () =>
          errorMessage = "No object exists at the desired reference.",
      bucketNotFound: () =>
          errorMessage = "No bucket is configured for Cloud Storage",
      projectNotFound: () =>
          errorMessage = "No project is configured for Cloud Storage",
      quotaExceeded: () => errorMessage =
          "Quota on your Cloud Storage bucket has been exceeded. If you're on the no-cost tier, upgrade to a paid plan. If you're on a paid plan, reach out to Firebase support.",
      unauthenticated: () => errorMessage =
          "User is unauthenticated, please authenticate and try again.",
      unauthorized: () => errorMessage =
          "User is not authorized to perform the desired action, check your security rules to ensure they are correct.",
      retryLimitExceeded: () => errorMessage =
          "The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded. Try uploading again.",
      invalidChecksum: () => errorMessage =
          "File on the client does not match the checksum of the file received by the server. Try uploading again.",
      cancelled: () => errorMessage = "User canceled the operation.",
      invalidEventName: () => errorMessage =
          "Invalid event name provided. Must be one of [running, progress, pause]",
      invalidUrl: () => errorMessage = "Invalid URL provided to refFromURL().",
      invalidArgument: () => errorMessage =
          "The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.",
      noDefaultBucket: () => errorMessage =
          "No bucket has been set in your config's storageBucket property.",
      cannotSliceBlob: () => errorMessage =
          "Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file hasn't changed.",
      serverFileWrongSize: () => errorMessage =
          "File on the client does not match the size of the file received by the server. Try uploading again.",
      timeout: () => errorMessage = "Request Timeout.",
    );
    return errorMessage;
  }
}
