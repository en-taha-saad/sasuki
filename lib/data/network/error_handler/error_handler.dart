import 'package:dio/dio.dart';
import 'package:sasuki/data/network/error_handler/datasource_enum.dart';
import 'package:sasuki/data/network/error_handler/datasource_extension.dart';
import 'package:sasuki/data/network/models/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // the error is from the Dio itself or from api
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.recieveTimeout.getFailure();
      case DioErrorType.response:
        return _handleResponseError(error);
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.other:
        return DataSource.defaultError.getFailure();
    }
  }

  Failure _handleResponseError(DioError error) {
    switch (error.response!.statusCode) {
      case 400:
        return DataSource.badRequest.getFailure();
      case 401:
        return DataSource.unauthorized.getFailure();
      case 403:
        return DataSource.forbidden.getFailure(error.response?.data['error']);
      case 404:
        return DataSource.notFound.getFailure();
      case 500:
        return DataSource.internalServerError.getFailure();
      default:
        return DataSource.defaultError.getFailure();
    }
  }
}
