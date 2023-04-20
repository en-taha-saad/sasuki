import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/shared_funs/get_payload.dart';
import 'package:sasuki/data/data_sources/local/local_data_source.dart';
import 'package:sasuki/data/data_sources/remote/remote_data_source.dart';
import 'package:sasuki/data/mappers/acl_permission_group_list_responses_mappers/acl_permission_group_list_responses_mappers.dart';
import 'package:sasuki/data/mappers/activate_method_responses_mappers/activate_method_responses_mappers.dart';
import 'package:sasuki/data/mappers/activation_informs_responses_mappers/activation_informs_responses_mappers.dart';
import 'package:sasuki/data/mappers/captcha_mappers/captcha_response_mapper.dart';
import 'package:sasuki/data/mappers/dashboard_mappers/dashboard_responses_mappers.dart';
import 'package:sasuki/data/mappers/extend_user_responses_mappers/allowed_extersion_methods_responses_mappers.dart';
import 'package:sasuki/data/mappers/extend_user_responses_mappers/extend_user_informs_responses_mappers.dart';
import 'package:sasuki/data/mappers/filterLists_mappers/parent_list_mapper.dart';
import 'package:sasuki/data/mappers/filterLists_mappers/profile_list_mapper.dart';
import 'package:sasuki/data/mappers/login_mappers/login_response_mapper.dart';
import 'package:sasuki/data/mappers/manager_action_response_mapper/manager_action_response_mapper.dart';
import 'package:sasuki/data/mappers/manager_apis_mappers/manager_details_responses_mappers.dart';
import 'package:sasuki/data/mappers/manager_apis_mappers/manager_overview_api_responses_mappers.dart';
import 'package:sasuki/data/mappers/manager_list_details_responses_mappers/manager_list_details_responses_mappers.dart';
import 'package:sasuki/data/mappers/manager_list_details_responses_mappers/security_group_responses_mappers.dart';
import 'package:sasuki/data/mappers/managers_list_responses_mappers/managers_list_responses_mappers.dart';
import 'package:sasuki/data/mappers/paydebt_informs_responses_mappers/paydebt_informs_responses_mappers.dart';
import 'package:sasuki/data/mappers/user_action_response_mapper/user_action_response_mapper.dart';
import 'package:sasuki/data/mappers/serversList_mappers/server_response_mapper.dart';
import 'package:sasuki/data/mappers/serversList_mappers/serverslist_response_mapper.dart';
import 'package:sasuki/data/mappers/user_apis_mappers/user_api_responses_mappers.dart';
import 'package:sasuki/data/mappers/user_apis_mappers/user_overview_api_responses_mappers.dart';
import 'package:sasuki/data/mappers/users_list_mappers/users_list_responses_mappers.dart';
import 'package:sasuki/data/network/error_handler/api_internal_status.dart';
import 'package:sasuki/data/network/error_handler/datasource_enum.dart';
import 'package:sasuki/data/network/error_handler/datasource_extension.dart';
import 'package:sasuki/data/network/error_handler/error_handler.dart';
import 'package:sasuki/data/network/error_handler/response_messages.dart';
import 'package:sasuki/data/network/internet_checker/network_info.dart';
import 'package:sasuki/data/network/models/change_profile_request.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/data/network/models/loginrequest.dart';
import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/models/activate_method/activate_method.dart';
import 'package:sasuki/domain/models/activation_informs/activation_informs.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/extend_user_informs/extend_user_informs.dart';
import 'package:sasuki/domain/models/extend_user_informs/allowed_extersion_methods.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/login/login.dart';
import 'package:sasuki/domain/models/manager_action/manager_action.dart';
import 'package:sasuki/domain/models/manager_details/manager_details.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/domain/models/manager_list_details/security_group.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';
import 'package:sasuki/domain/models/paydebt_informs/paydebt_informs.dart';
import 'package:sasuki/domain/models/user_action/edit_user.dart';
import 'package:sasuki/domain/models/user_action/user_action.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/domain/models/user_details/user_api.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

import '../../domain/models/choosing_server/servers.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;

  RepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, ServersList>> getServers() async {
    try {
      // get response from storage
      ServersListResponse? res;
      await _localDataSource.getServersData().then((value) {
        res = value;
      });
      // ignore: prefer_is_empty, unnecessary_null_comparison
      if (res != null) {
        // success reutrn either right
        // save servers response to storage

        return Right(res.toDomain());
      } else {
        // failure return either left business error
        return Left(
          Failure(
            ApiInternalStatus.failure,
            ResponseMessage.storedStorageError,
          ),
        );
      }
    } catch (storageError) {
      // storage is empty
      return Left(ErrorHandler.handle(storageError).failure);
    }
  }

  @override
  Future<Either<Failure, Server>> getSelectedServer() async {
    try {
      // get response from storage
      ServerResponse? res;
      await _localDataSource.getSelectedServerFromShared().then((value) {
        res = value;
      });
      // ignore: prefer_is_empty, unnecessary_null_comparison
      if (res != null) {
        // success reutrn either right
        // save servers response to storage

        return Right(res.toDomain());
      } else {
        // failure return either left business error
        return Left(
          Failure(
            ApiInternalStatus.failure,
            ResponseMessage.storedStorageError,
          ),
        );
      }
    } catch (storageError) {
      // storage is empty
      return Left(ErrorHandler.handle(storageError).failure);
    }
  }

  @override
  Future<Either<Failure, bool?>> addServer(Server? server) async {
    try {
      // get response from storage
      bool? res;
      await _localDataSource
          .addServerToShared(
              ServerResponse(server?.name, server?.hostName, "", ""))
          .then((value) {
        res = value;
      });
      // ignore: prefer_is_empty, unnecessary_null_comparison
      if (res != null) {
        // success reutrn either right
        // save servers response to storage

        return Right(res);
      } else {
        // failure return either left business error
        return Left(
          Failure(
            ApiInternalStatus.failure,
            ResponseMessage.storedStorageError,
          ),
        );
      }
    } catch (storageError) {
      // storage is empty
      return Left(ErrorHandler.handle(storageError).failure);
    }
  }

  @override
  Future<Either<Failure, bool?>> removeServer(String? serverName) async {
    try {
      // get response from storage
      // ignore: prefer_typing_uninitialized_variables
      var res;
      await _localDataSource.removeServerFromShared(serverName!).then((value) {
        res = value;
      });
      // ignore: prefer_is_empty, unnecessary_null_comparison
      if (res != null) {
        // success reutrn either right
        // save servers response to storage

        return Right(res);
      } else {
        // failure return either left business error
        return Left(
          Failure(
            ApiInternalStatus.failure,
            ResponseMessage.storedStorageError,
          ),
        );
      }
    } catch (storageError) {
      // storage is empty
      return Left(ErrorHandler.handle(storageError).failure);
    }
  }

  @override
  Future<Either<Failure, Login>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.login(getPayload({
          "username": loginRequest.username,
          "password": loginRequest.password,
          "language": loginRequest.language,
          "otp": loginRequest.otp,
          "captcha_text": loginRequest.captchaText,
          "session_id": loginRequest.sessionId,
        })); // !D/EGL_emulation( 8442): app_time_stats:
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status,
              "$response",
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Captcha>> isCaptchaRequired() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.isCaptchaRequired();
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.failure,
              "${response.status}",
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, DataCaptcha>> getCaptcha(String sessionId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getCaptcha(sessionId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.failure,
              "${response.status}",
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> getAuth() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getAuth();
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.failure,
              "${response.status}",
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Dashboard>> getDashboardData() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getDashboardData();
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.failure,
              "${response.status}",
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UsersList>> getUsersList(
    UserRequestObject userRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      debugPrint("@@@@${{
        "page": userRequest.page,
        "count": userRequest.count,
        "sortBy": userRequest.sortBy,
        "direction": userRequest.direction,
        "search": userRequest.search,
        "columns": userRequest.columns,
        "status": userRequest.status,
        "connection": userRequest.connection,
        "profile_id": userRequest.profileId,
        "parent_id": userRequest.parentId,
      }}");
      try {
        final response = await _remoteDataSource.getUsersList(
          getPayload({
            "page": userRequest.page,
            "count": userRequest.count,
            "sortBy": userRequest.sortBy,
            "direction": userRequest.direction,
            "search": userRequest.search,
            "columns": userRequest.columns,
            "status": userRequest.status,
            "connection": userRequest.connection,
            "profile_id": userRequest.profileId,
            "parent_id": userRequest.parentId,
          }),
        );

        if (response.data != null) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SingleParentData>>> getParentList() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getParentList();
        if (response.length != Constants.zeroNum) {
          // success reutrn either right
          return Right(
            response.map((e) => e.toDomain()).toList(),
          );
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileList>> getProfileList() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getProfileList();
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserApi>> getUserApi(int userId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getUserApi(userId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserOverviewApi>> getUserOverviewApi(
    int userId,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getUserOverviewApi(userId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> deleteUser(int userId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.deleteUser(userId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.nonDeletedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> renameUser(
    String newUsername,
    int userId,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.renameUser(
          getPayload({
            "new_username": newUsername,
          }),
          userId,
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.alreadyNamedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> changeUserProfile(
    ChangeProfileRequest changeProfileRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.changeUserProfile(
          getPayload(changeProfileRequest.toJson()),
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.alreadyNamedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ActivationInforms>> getActivationInforms(
      int userId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getActivationInforms(userId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ActivateMethod>> activateUser(
    ActivationRequestObject activationRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.activateUser(
          getPayload(
            {
              "method": activationRequestObject.method,
              "pin": activationRequestObject.pin,
              "user_id": activationRequestObject.userId,
              "money_collected": activationRequestObject.moneyCollected,
              "comments": activationRequestObject.comments,
              "user_price": activationRequestObject.userPrice,
              "issue_invoice": activationRequestObject.issueInvoice,
              "transaction_id": activationRequestObject.transactionId,
              "activation_units": activationRequestObject.activationUnits,
            },
          ),
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.alreadyNamedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> addUser(
    AddUserRequestObject addUserRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "username": addUserRequestObject.username,
          "enabled": addUserRequestObject.enabled,
          "password": addUserRequestObject.password,
          "confirm_password": addUserRequestObject.password,
          "profile_id": addUserRequestObject.profileId,
          "parent_id": addUserRequestObject.parentId,
          "firstname": addUserRequestObject.firstname,
          "lastname": addUserRequestObject.lastname,
          "phone": addUserRequestObject.phone,
          "notes": addUserRequestObject.notes,
        }}");
        final response = await _remoteDataSource.addUser(
          getPayload(
            {
              "username": addUserRequestObject.username,
              "enabled": addUserRequestObject.enabled,
              "password": addUserRequestObject.password,
              "confirm_password": addUserRequestObject.password,
              "profile_id": addUserRequestObject.profileId,
              "parent_id": addUserRequestObject.parentId,
              // "site_id": addUserRequestObject.siteId,
              // "mac_auth": addUserRequestObject.macAuth,
              // "allowed_macs": addUserRequestObject.allowedMacs,
              // "use_separate_portal_password":
              //     addUserRequestObject.useSeparatePortalPassword,
              // "portal_password": addUserRequestObject.portalPassword,
              // "group_id": addUserRequestObject.groupId,
              "firstname": addUserRequestObject.firstname,
              "lastname": addUserRequestObject.lastname,
              // "company": addUserRequestObject.company,
              // "email": addUserRequestObject.email,
              "phone": addUserRequestObject.phone,
              // "city": addUserRequestObject.city,
              // "address": addUserRequestObject.address,
              // "apartment": addUserRequestObject.apartment,
              // "street": addUserRequestObject.street,
              // "contract_id": addUserRequestObject.contractId,
              // "national_id": addUserRequestObject.nationalId,
              "notes": addUserRequestObject.notes,
              // "auto_renew": addUserRequestObject.autoRenew,
              // "expiration": addUserRequestObject.expiration,
              // "simultaneous_sessions":
              //     addUserRequestObject.simultaneousSessions,
              // "static_ip": addUserRequestObject.staticIp,
              // "mikrotik_winbox_group": Constants.nullValue,
              // "mikrotik_framed_route": Constants.nullValue,
              // "mikrotik_addresslist": Constants.nullValue,
              // "mikrotik_ipv6_prefix": Constants.nullValue,
              // "user_type": addUserRequestObject.userType,
              // "restricted": addUserRequestObject.restricted,
            },
          ),
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.alreadyNamedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, EditUser>> editUser(
    AddUserRequestObject editUserRequestObject,
    int userId,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "username": editUserRequestObject.username,
          "enabled": editUserRequestObject.enabled,
          "password": editUserRequestObject.password,
          "confirm_password": editUserRequestObject.password,
          "profile_id": editUserRequestObject.profileId,
          "parent_id": editUserRequestObject.parentId,
          "firstname": editUserRequestObject.firstname,
          "lastname": editUserRequestObject.lastname,
          "phone": editUserRequestObject.phone,
          "notes": editUserRequestObject.notes,
        }}");
        final response = await _remoteDataSource.editUser(
          getPayload(
            {
              "username": editUserRequestObject.username,
              "enabled": editUserRequestObject.enabled,
              "password": editUserRequestObject.password,
              "confirm_password": editUserRequestObject.password,
              "profile_id": editUserRequestObject.profileId,
              "parent_id": editUserRequestObject.parentId,
              "firstname": editUserRequestObject.firstname,
              "lastname": editUserRequestObject.lastname,
              "phone": editUserRequestObject.phone,
              "notes": editUserRequestObject.notes,
            },
          ),
          userId,
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.alreadyNamedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> extendUser(
    ExtendUserRequestObject extendUserRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "user_id": extendUserRequestObject.userId,
          "profile_id": extendUserRequestObject.profileId,
          "method": extendUserRequestObject.method,
          "transaction_id": extendUserRequestObject.transactionId
        }}");
        final response = await _remoteDataSource.extendUser(getPayload(
          {
            "user_id": extendUserRequestObject.userId,
            "profile_id": extendUserRequestObject.profileId,
            "method": extendUserRequestObject.method,
            "transaction_id": extendUserRequestObject.transactionId
          },
        ));
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status ?? ApiInternalStatus.minusFourStatusCode,
              response.message ?? AppStrings.invalidProfileType,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ExtendUserInforms>> extendUserInforms(
    int userId,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.extendUserInforms(userId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AllowedExtersionMethods>> getAllowedExtensions(
    int profileId,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response =
            await _remoteDataSource.getAllowedExtensions(profileId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> deposit(
      DepositWithdrawUserRequestObject depositWithdrawUserRequestObject) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "user_id": depositWithdrawUserRequestObject.userId,
          "user_username": depositWithdrawUserRequestObject.userUsername,
          "amount": depositWithdrawUserRequestObject.amount,
          "comment": depositWithdrawUserRequestObject.comment,
          "transaction_id": depositWithdrawUserRequestObject.transactionId,
        }}");
        final response = await _remoteDataSource.deposit(getPayload(
          {
            "user_id": depositWithdrawUserRequestObject.userId,
            "user_username": depositWithdrawUserRequestObject.userUsername,
            "amount": depositWithdrawUserRequestObject.amount,
            "comment": depositWithdrawUserRequestObject.comment,
            "transaction_id": depositWithdrawUserRequestObject.transactionId,
          },
        ));
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.message!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> withdraw(
      DepositWithdrawUserRequestObject depositWithdrawUserRequestObject) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "user_id": depositWithdrawUserRequestObject.userId,
          "user_username": depositWithdrawUserRequestObject.userUsername,
          "amount": depositWithdrawUserRequestObject.amount,
          "comment": depositWithdrawUserRequestObject.comment,
          "transaction_id": depositWithdrawUserRequestObject.transactionId,
        }}");
        final response = await _remoteDataSource.deposit(getPayload(
          {
            "user_id": depositWithdrawUserRequestObject.userId,
            "user_username": depositWithdrawUserRequestObject.userUsername,
            "amount": depositWithdrawUserRequestObject.amount,
            "comment": depositWithdrawUserRequestObject.comment,
            "transaction_id": depositWithdrawUserRequestObject.transactionId,
          },
        ));
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.message!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> payDebt(
      PayDebtRequestObject payDebtRequestObject) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "user_id": payDebtRequestObject.userId,
          "username": payDebtRequestObject.username,
          "amount": payDebtRequestObject.amount,
          "comment": payDebtRequestObject.comment,
          "transaction_id": payDebtRequestObject.transactionId,
          "is_loan": payDebtRequestObject.isLoan,
          "debt_for_me": payDebtRequestObject.debtForMe,
          "debt": payDebtRequestObject.debt
        }}");
        final response = await _remoteDataSource.payDebt(
          getPayload(
            {
              "user_id": payDebtRequestObject.userId,
              "username": payDebtRequestObject.username,
              "amount": payDebtRequestObject.amount,
              "comment": payDebtRequestObject.comment,
              "transaction_id": payDebtRequestObject.transactionId,
              "is_loan": payDebtRequestObject.isLoan,
              "debt_for_me": payDebtRequestObject.debtForMe,
              "debt": payDebtRequestObject.debt
            },
          ),
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.message!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, PaydebtInforms>> getPayDebtInforms(int userId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getPayDebtInforms(userId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagersList>> getManagersList() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getManagersList();
        if (response.i0 == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AclPermissionGroupList>>
      getAclPermissionGroupList() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getAclPermissionGroupList();
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerListDetails>> getManagersListDetails(
    ManagerRequestObject managersListRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload= ${{
          "page": managersListRequestObject.page,
          "count": managersListRequestObject.count,
          "sortBy": managersListRequestObject.sortBy,
          "direction": managersListRequestObject.direction,
          "search": managersListRequestObject.search,
          "columns": managersListRequestObject.columns,
          "parent_id": managersListRequestObject.parentId,
          "sub_managers": managersListRequestObject.subManagers,
          "site_id": managersListRequestObject.siteId,
          "acl_group_id": managersListRequestObject.aclGroupId,
          "group_id": managersListRequestObject.groupId,
        }}");
        final response = await _remoteDataSource.getManagersListDetails(
          getPayload({
            "page": managersListRequestObject.page,
            "count": managersListRequestObject.count,
            "sortBy": managersListRequestObject.sortBy,
            "direction": managersListRequestObject.direction,
            "search": managersListRequestObject.search,
            "columns": managersListRequestObject.columns,
            "parent_id": managersListRequestObject.parentId,
            "sub_managers": managersListRequestObject.subManagers,
            "site_id": managersListRequestObject.siteId,
            "acl_group_id": managersListRequestObject.aclGroupId,
            "group_id": managersListRequestObject.groupId,
          }),
        );
        if (response != Constants.nullValue) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              0,
              "No Managers Found",
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerOverviewApi>> getManagerOverviewApi(
    int managerId,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response =
            await _remoteDataSource.getManagerOverviewApi(managerId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(ApiInternalStatus.twoAuthStatus, "$response"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerAction>> deleteManager(int managerId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.deleteManager(managerId);
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.error!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerAction>> renameManager(
      String newUsername, int managerId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.renameManager(
          getPayload({
            "username": newUsername,
          }),
          managerId,
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.error!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerAction>> depositManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
          "manager_username":
              depositWithdrawPayDebtManagerRequestObject.managerUsername,
          "amount": depositWithdrawPayDebtManagerRequestObject.amount,
          "comment": depositWithdrawPayDebtManagerRequestObject.comment,
          "transaction_id":
              depositWithdrawPayDebtManagerRequestObject.transactionId,
          "is_loan": depositWithdrawPayDebtManagerRequestObject.isLoan,
        }}");
        final response = await _remoteDataSource.depositManager(getPayload(
          {
            "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
            "manager_username":
                depositWithdrawPayDebtManagerRequestObject.managerUsername,
            "amount": depositWithdrawPayDebtManagerRequestObject.amount,
            "comment": depositWithdrawPayDebtManagerRequestObject.comment,
            "transaction_id":
                depositWithdrawPayDebtManagerRequestObject.transactionId,
            "is_loan": depositWithdrawPayDebtManagerRequestObject.isLoan,
          },
        ));
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.error!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerAction>> withdrawManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
          "manager_username":
              depositWithdrawPayDebtManagerRequestObject.managerUsername,
          "amount": depositWithdrawPayDebtManagerRequestObject.amount,
          "comment": depositWithdrawPayDebtManagerRequestObject.comment,
          "transaction_id":
              depositWithdrawPayDebtManagerRequestObject.transactionId,
          "is_loan": depositWithdrawPayDebtManagerRequestObject.isLoan,
        }}");
        final response = await _remoteDataSource.withdrawManager(getPayload(
          {
            "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
            "manager_username":
                depositWithdrawPayDebtManagerRequestObject.managerUsername,
            "amount": depositWithdrawPayDebtManagerRequestObject.amount,
            "comment": depositWithdrawPayDebtManagerRequestObject.comment,
            "transaction_id":
                depositWithdrawPayDebtManagerRequestObject.transactionId,
            "is_loan": depositWithdrawPayDebtManagerRequestObject.isLoan,
          },
        ));
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.error!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerAction>> paydebtManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
          "manager_username":
              depositWithdrawPayDebtManagerRequestObject.managerUsername,
          "amount": depositWithdrawPayDebtManagerRequestObject.amount,
          "comment": depositWithdrawPayDebtManagerRequestObject.comment,
          "transaction_id":
              depositWithdrawPayDebtManagerRequestObject.transactionId,
          "is_loan": depositWithdrawPayDebtManagerRequestObject.isLoan,
        }}");
        final response = await _remoteDataSource.paydebtManager(getPayload(
          {
            "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
            "manager_username":
                depositWithdrawPayDebtManagerRequestObject.managerUsername,
            "amount": depositWithdrawPayDebtManagerRequestObject.amount,
            "comment": depositWithdrawPayDebtManagerRequestObject.comment,
            "transaction_id":
                depositWithdrawPayDebtManagerRequestObject.transactionId,
            "is_loan": depositWithdrawPayDebtManagerRequestObject.isLoan,
          },
        ));
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.error!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerAction>> addRewardPointsManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
          "amount": depositWithdrawPayDebtManagerRequestObject.amount,
        }}");
        final response =
            await _remoteDataSource.addRewardPointsManager(getPayload(
          {
            "manager_id": depositWithdrawPayDebtManagerRequestObject.managerId,
            "amount": depositWithdrawPayDebtManagerRequestObject.amount,
          },
        ));
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              response.status!,
              response.error!,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, SecurityGroup>> getSecurityGroupList() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getSecurityGroupList();
        // ignore: unrelated_type_equality_checks
        if (response.data != Constants.zeroNum) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(response.status ?? 0, "${response.status ?? 0}"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, EditUser>> addManager(
    AddEditManagerRequestObject addEditManagerRequestObject,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "username": addEditManagerRequestObject.username,
          "enabled": addEditManagerRequestObject.enabled,
          "password": addEditManagerRequestObject.password,
          "confirm_password": addEditManagerRequestObject.password,
          "acl_group_id": addEditManagerRequestObject.aclGroupId,
          "parent_id": addEditManagerRequestObject.parentId,
          "firstname": addEditManagerRequestObject.firstname,
          "lastname": addEditManagerRequestObject.lastname,
          "company": addEditManagerRequestObject.company,
          "email": addEditManagerRequestObject.email,
          "phone": addEditManagerRequestObject.phone,
          "city": addEditManagerRequestObject.city,
          "address": addEditManagerRequestObject.address,
          "notes": addEditManagerRequestObject.notes,
        }}");
        final response = await _remoteDataSource.addManager(
          getPayload({
            "username": addEditManagerRequestObject.username,
            "enabled": addEditManagerRequestObject.enabled,
            "password": addEditManagerRequestObject.password,
            "confirm_password": addEditManagerRequestObject.password,
            "acl_group_id": addEditManagerRequestObject.aclGroupId,
            "parent_id": addEditManagerRequestObject.parentId,
            "firstname": addEditManagerRequestObject.firstname,
            "lastname": addEditManagerRequestObject.lastname,
            "company": addEditManagerRequestObject.company,
            "email": addEditManagerRequestObject.email,
            "phone": addEditManagerRequestObject.phone,
            "city": addEditManagerRequestObject.city,
            "address": addEditManagerRequestObject.address,
            "notes": addEditManagerRequestObject.notes,
          }),
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.alreadyNamedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserAction>> editManager(
    AddEditManagerRequestObject addEditManagerRequestObject,
    int managerId,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        debugPrint("getPayload = ${{
          "username": addEditManagerRequestObject.username,
          "enabled": addEditManagerRequestObject.enabled,
          "password": addEditManagerRequestObject.password,
          "confirm_password": addEditManagerRequestObject.password,
          "acl_group_id": addEditManagerRequestObject.aclGroupId,
          "parent_id": addEditManagerRequestObject.parentId,
          "firstname": addEditManagerRequestObject.firstname,
          "lastname": addEditManagerRequestObject.lastname,
          "company": addEditManagerRequestObject.company,
          "email": addEditManagerRequestObject.email,
          "phone": addEditManagerRequestObject.phone,
          "city": addEditManagerRequestObject.city,
          "address": addEditManagerRequestObject.address,
          "notes": addEditManagerRequestObject.notes,
        }}");
        final response = await _remoteDataSource.editManager(
          getPayload({
            "username": addEditManagerRequestObject.username,
            "enabled": addEditManagerRequestObject.enabled,
            "password": addEditManagerRequestObject.password,
            "confirm_password": addEditManagerRequestObject.password,
            "acl_group_id": addEditManagerRequestObject.aclGroupId,
            "parent_id": addEditManagerRequestObject.parentId,
            "firstname": addEditManagerRequestObject.firstname,
            "lastname": addEditManagerRequestObject.lastname,
            "company": addEditManagerRequestObject.company,
            "email": addEditManagerRequestObject.email,
            "phone": addEditManagerRequestObject.phone,
            "city": addEditManagerRequestObject.city,
            "address": addEditManagerRequestObject.address,
            "notes": addEditManagerRequestObject.notes,
          }),
          managerId,
        );
        if (response.status == ApiInternalStatus.success) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(
              ApiInternalStatus.minusOneStatusCode,
              AppStrings.alreadyNamedError,
            ),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerDetails>> getManagerDetails(
      int managerId) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet so we can call the api
      try {
        final response = await _remoteDataSource.getManagerDetails(managerId);
        // ignore: unrelated_type_equality_checks
        if (response.data != Constants.zeroNum) {
          // success reutrn either right
          return Right(response.toDomain());
        } else {
          // failure return either left business error
          return Left(
            Failure(response.status ?? 0, "${response.status ?? 0}"),
          );
        }
      } catch (error) {
        debugPrint("error = $error");

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // its not connected to internet so return a failure
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
