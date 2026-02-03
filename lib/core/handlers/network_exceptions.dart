import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.connectionError() = ConnectionError;

  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  const factory NetworkExceptions.badCertificate() = BadCertificate;

  static String getRawErrorMessage(dynamic error) {
    if (error is DioException && error.response?.data != null) {
      try {
        if (error.response!.data is Map<String, dynamic>) {
          final errorData = error.response!.data as Map<String, dynamic>;
          if (errorData.containsKey('error')) {
            return errorData['error'].toString();
          } else if (errorData.containsKey('message')) {
            return errorData['message'].toString();
          } else {
            return json.encode(errorData);
          }
        } else if (error.response!.data is String) {
          return error.response!.data as String;
        } else {
          return error.response!.data.toString();
        }
      } catch (e) {
        return error.toString();
      }
    } else if (error is NetworkExceptions) {
      return _extractMessageFromNetworkExceptions(error);
    }

    return error.toString();
  }

  static String _extractMessageFromNetworkExceptions(
      NetworkExceptions networkExceptions) {
    return networkExceptions.when(
      connectionError: () => "Connection error",
      requestCancelled: () => "Request cancelled",
      unauthorisedRequest: () => "Unauthorized request",
      badRequest: () => "Bad request",
      notFound: (reason) => reason,
      methodNotAllowed: () => "Method not allowed",
      notAcceptable: () => "Not acceptable",
      requestTimeout: () => "Request timeout",
      sendTimeout: () => "Send timeout",
      conflict: () => "Conflict",
      internalServerError: () => "Internal server error",
      notImplemented: () => "Not implemented",
      serviceUnavailable: () => "Service unavailable",
      noInternetConnection: () => "No internet connection",
      formatException: () => "Format exception",
      unableToProcess: () => "Unable to process",
      defaultError: (error) => error,
      unexpectedError: () => "Unexpected error",
      badCertificate: () => "Bad certificate",
    );
  }

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions? networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.connectionError:
              return const NetworkExceptions.connectionError();
            case DioExceptionType.cancel:
              return const NetworkExceptions.requestCancelled();
            case DioExceptionType.connectionTimeout:
              return const NetworkExceptions.requestTimeout();
            case DioExceptionType.unknown:
              return const NetworkExceptions.noInternetConnection();
            case DioExceptionType.receiveTimeout:
              return const NetworkExceptions.sendTimeout();
            case DioExceptionType.badCertificate:
              return const NetworkExceptions.badCertificate();
            case DioExceptionType.sendTimeout:
              return const NetworkExceptions.sendTimeout();
            case DioExceptionType.badResponse:
              // For responses, always extract and return the backend error message
              String backendError =
                  _extractBackendErrorMessage(error.response?.data);
              return NetworkExceptions.defaultError(backendError);
          }
        } else if (error is SocketException) {
          return const NetworkExceptions.noInternetConnection();
        } else {
          return const NetworkExceptions.unexpectedError();
        }
        return networkExceptions ?? const NetworkExceptions.unexpectedError();
      } on FormatException catch (_) {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String _extractBackendErrorMessage(dynamic data) {
    if (data == null) return "Unknown error occurred";

    try {
      // For JSON error responses
      if (data is Map<String, dynamic>) {
        if (data.containsKey('error')) {
          return data['error'].toString();
        } else if (data.containsKey('message')) {
          return data['message'].toString();
        } else {
          return json.encode(data);
        }
      } else if (data is String && data.isNotEmpty) {
        try {
          final jsonData = json.decode(data);
          if (jsonData is Map<String, dynamic>) {
            if (jsonData.containsKey('error')) {
              return jsonData['error'].toString();
            } else if (jsonData.containsKey('message')) {
              return jsonData['message'].toString();
            }
          }
          return data;
        } catch (_) {
          return data;
        }
      } else {
        return data.toString();
      }
    } catch (_) {
      return "Error processing response";
    }
  }
}
