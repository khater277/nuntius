import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius/core/errors/api/error_model/error_model.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions implements Exception {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest(String reason) = BadRequest;
  const factory NetworkExceptions.forbidden(String reason) = Forbidden;
  const factory NetworkExceptions.notFound(String reason) = NotFound;
  const factory NetworkExceptions.notAcceptable(String reason) = NotAcceptable;
  const factory NetworkExceptions.unsupportedMediaType(String reason) =
      UnsupportedMediaType;
  const factory NetworkExceptions.tooManyRequests(String reason) =
      TooManyRequests;
  const factory NetworkExceptions.internalServerError(String reason) =
      InternalServerError;
  const factory NetworkExceptions.badGateway(String reason) = BadGateway;
  const factory NetworkExceptions.serviceUnavailable(String reason) =
      ServiceUnavailable;
  const factory NetworkExceptions.serviceNotFound(String reason) =
      ServiceNotFound;

  const factory NetworkExceptions.methodNotAllowed(String reason) =
      MethodNotAllowed;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.badCertificate() = BadCertificate;
  const factory NetworkExceptions.connectionError() = ConnectionError;
  const factory NetworkExceptions.receiveTimeout() = ReceiveTimeout;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict(String reason) = Conflict;

  const factory NetworkExceptions.notImplemented(String reason) =
      NotImplemented;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException(String reason) =
      FormatException;

  const factory NetworkExceptions.unableToProcess(String reason) =
      UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError(String reason) =
      UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    ErrorModel errorModel = ErrorModel.fromJson(response?.data['error']);

    int statusCode = response?.statusCode ?? 0;

    switch (statusCode) {
      case 400:
        return NetworkExceptions.badRequest("${errorModel.message}");
      case 401:
      case 403:
        return NetworkExceptions.forbidden("${errorModel.message}");
      case 404:
        return NetworkExceptions.notFound("${errorModel.message}");
      case 406:
        return NetworkExceptions.notAcceptable("${errorModel.message}");

      case 408:
        return const NetworkExceptions.requestTimeout();
      case 409:
        return NetworkExceptions.conflict("${errorModel.message}");
      case 415:
        return NetworkExceptions.unsupportedMediaType("${errorModel.message}");
      case 422:
        return NetworkExceptions.unprocessableEntity("${errorModel.message}");
      case 429:
        return NetworkExceptions.tooManyRequests("${errorModel.message}");
      case 500:
        return NetworkExceptions.internalServerError("${errorModel.message}");
      case 501:
        return NetworkExceptions.badGateway("${errorModel.message}");
      case 503:
        return NetworkExceptions.serviceUnavailable("${errorModel.message}");
      case 596:
        return NetworkExceptions.serviceNotFound("${errorModel.message}");
      default:
        var responseCode = statusCode;
        return NetworkExceptions.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        late NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;

            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.badCertificate();
              break;
            case DioExceptionType.connectionError:
              networkExceptions = const NetworkExceptions.connectionError();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions =
              const NetworkExceptions.unexpectedError("un expected error");
        }
        return networkExceptions;
        // ignore: unused_catch_clause
      } on FormatException catch (e) {
        return const NetworkExceptions.formatException("format exception");
      } catch (_) {
        return const NetworkExceptions.unexpectedError("un expected error");
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess("unable to process");
      } else {
        return const NetworkExceptions.unexpectedError("un expected error");
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(
      requestCancelled: () => errorMessage = "request cancelled",
      unauthorizedRequest: (msg) => errorMessage = msg,
      badRequest: (msg) => errorMessage = msg,
      forbidden: (msg) => errorMessage = msg,
      notFound: (msg) => errorMessage = msg,
      notAcceptable: (msg) => errorMessage = msg,
      unsupportedMediaType: (msg) => errorMessage = msg,
      tooManyRequests: (msg) => errorMessage = msg,
      internalServerError: (msg) => errorMessage = msg,
      badGateway: (msg) => errorMessage = msg,
      serviceUnavailable: (msg) => errorMessage = msg,
      serviceNotFound: (msg) => errorMessage = msg,
      methodNotAllowed: (msg) => errorMessage = msg,
      requestTimeout: () => errorMessage = "request timeout",
      sendTimeout: () => errorMessage = 'sent timeout',
      badCertificate: () => errorMessage = 'Bad Certificate',
      connectionError: () => errorMessage = 'Connection Error',
      receiveTimeout: () => errorMessage = 'Receive Timeout',
      unprocessableEntity: (msg) => errorMessage = msg,
      conflict: (msg) => errorMessage = msg,
      notImplemented: (msg) => errorMessage = msg,
      noInternetConnection: () =>
          errorMessage = 'there is no internet connection',
      formatException: (msg) => errorMessage = msg,
      unableToProcess: (msg) => errorMessage = msg,
      defaultError: (msg) => errorMessage = msg,
      unexpectedError: (msg) => errorMessage = msg,
    );
    return errorMessage;
  }
}
