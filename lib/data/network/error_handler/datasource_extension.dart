import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/data/network/error_handler/datasource_enum.dart';
import 'package:sasuki/data/network/error_handler/response_code.dart';
import 'package:sasuki/data/network/error_handler/response_messages.dart';
import 'package:sasuki/data/network/models/failure.dart';

extension DataSourceExtension on DataSource {
  Failure getFailure([String? message]) {
    switch (this) {
      case DataSource.success:
        return Failure(
          ResponseCode.success,
          ResponseMessage.success,
        );
      case DataSource.noContent:
        return Failure(
          ResponseCode.noContent,
          ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return Failure(
          ResponseCode.badRequest,
          ResponseMessage.badRequest,
        );
      case DataSource.unauthorized:
        return Failure(
          ResponseCode.unauthorized,
          ResponseMessage.unauthorized,
        );
      case DataSource.forbidden:
        return Failure(
          ResponseCode.forbidden,
          message == AppStrings.serInvalidUsernameError
              ? AppStrings.showLoginError
              : ResponseMessage.forbidden,
        );
      case DataSource.notFound:
        return Failure(
          ResponseCode.notFound,
          ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return Failure(
          ResponseCode.connectTimeout,
          ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(
          ResponseCode.cancel,
          ResponseMessage.cancel,
        );
      case DataSource.recieveTimeout:
        return Failure(
          ResponseCode.recieveTimeout,
          ResponseMessage.recieveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(
          ResponseCode.sendTimeout,
          ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return Failure(
          ResponseCode.cacheError,
          ResponseMessage.cacheError,
        );
      case DataSource.storedStorageError:
        return Failure(
          ResponseCode.storedStorageError,
          ResponseMessage.storedStorageError,
        );

      case DataSource.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection,
        );
      case DataSource.defaultError:
        return Failure(
          ResponseCode.defaultError,
          ResponseMessage.defaultError,
        );
    }
  }
}
