import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/change_profile_request.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/data/network/models/loginrequest.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/models/activate_method/activate_method.dart';
import 'package:sasuki/domain/models/activation_informs/activation_informs.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/models/choosing_server/servers.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/extend_user_informs/allowed_extersion_methods.dart';
import 'package:sasuki/domain/models/extend_user_informs/extend_user_informs.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/login/login.dart';
import 'package:sasuki/domain/models/manager_action/manager_action.dart';
import 'package:sasuki/domain/models/manager_details/manager_details.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';
import 'package:sasuki/domain/models/manager_list_details/security_group.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/domain/models/paydebt_informs/paydebt_informs.dart';
import 'package:sasuki/domain/models/user_action/edit_user.dart';
import 'package:sasuki/domain/models/user_action/user_action.dart';
import 'package:sasuki/domain/models/user_details/user_api.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

abstract class Repository {
  Future<Either<Failure, ServersList>> getServers();
  Future<Either<Failure, Server>> getSelectedServer();
  Future<Either<Failure, bool?>> addServer(Server? server);
  Future<Either<Failure, bool?>> removeServer(String? serverName);
  Future<Either<Failure, Login>> login(LoginRequest loginRequest);
  Future<Either<Failure, Captcha>> isCaptchaRequired();
  Future<Either<Failure, DataCaptcha>> getCaptcha(String sessionId);
  Future<Either<Failure, Auth>> getAuth();
  Future<Either<Failure, Dashboard>> getDashboardData();
  Future<Either<Failure, UsersList>> getUsersList(
      UserRequestObject userRequest);
  Future<Either<Failure, List<SingleParentData>>> getParentList();
  Future<Either<Failure, ProfileList>> getProfileList();
  Future<Either<Failure, UserApi>> getUserApi(int userId);
  Future<Either<Failure, UserOverviewApi>> getUserOverviewApi(int userId);
  Future<Either<Failure, UserAction>> deleteUser(int userId);
  Future<Either<Failure, UserAction>> renameUser(
      String newUsername, int userId);
  Future<Either<Failure, UserAction>> changeUserProfile(
    ChangeProfileRequest changeProfileRequest,
  );
  Future<Either<Failure, ActivationInforms>> getActivationInforms(int userId);
  Future<Either<Failure, ActivateMethod>> activateUser(
    ActivationRequestObject activationRequestObject,
  );

  Future<Either<Failure, UserAction>> addUser(
    AddUserRequestObject addUserRequestObject,
  );
  Future<Either<Failure, EditUser>> editUser(
    AddUserRequestObject editUserRequestObject,
    int userId,
  );

  Future<Either<Failure, ExtendUserInforms>> extendUserInforms(int userId);
  Future<Either<Failure, AllowedExtersionMethods>> getAllowedExtensions(
    int profileId,
  );
  Future<Either<Failure, UserAction>> extendUser(
    ExtendUserRequestObject extendUserRequestObject,
  );

  Future<Either<Failure, UserAction>> deposit(
    DepositWithdrawUserRequestObject depositWithdrawUserRequestObject,
  );

  Future<Either<Failure, UserAction>> withdraw(
    DepositWithdrawUserRequestObject depositWithdrawUserRequestObject,
  );

  Future<Either<Failure, UserAction>> payDebt(
    PayDebtRequestObject payDebtRequestObject,
  );
  Future<Either<Failure, PaydebtInforms>> getPayDebtInforms(int userId);

  Future<Either<Failure, ManagersList>> getManagersList();
  Future<Either<Failure, AclPermissionGroupList>> getAclPermissionGroupList();

  Future<Either<Failure, ManagerListDetails>> getManagersListDetails(
    ManagerRequestObject managersListRequestObject,
  );
  Future<Either<Failure, ManagerOverviewApi>> getManagerOverviewApi(
    int managerId,
  );
  Future<Either<Failure, ManagerAction>> deleteManager(int managerId);
  Future<Either<Failure, ManagerAction>> renameManager(
    String newUsername,
    int managerId,
  );
  Future<Either<Failure, ManagerAction>> depositManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  );

  Future<Either<Failure, ManagerAction>> withdrawManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  );

  Future<Either<Failure, ManagerAction>> paydebtManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  );
  Future<Either<Failure, ManagerAction>> addRewardPointsManager(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  );
  Future<Either<Failure, SecurityGroup>> getSecurityGroupList();

  Future<Either<Failure, EditUser>> addManager(
    AddEditManagerRequestObject addEditManagerRequestObject,
  );
  Future<Either<Failure, UserAction>> editManager(
    AddEditManagerRequestObject addEditManagerRequestObject,
    int managerId,
  );

  Future<Either<Failure, ManagerDetails>> getManagerDetails(int managerId);
}
