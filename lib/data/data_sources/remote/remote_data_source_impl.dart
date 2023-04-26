import 'package:dio/dio.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/shared_funs/get_selectedserver_fromlocal.dart';
import 'package:sasuki/data/data_sources/remote/remote_data_source.dart';
import 'package:sasuki/data/network/app_api.dart';
import 'package:sasuki/data/network/dio_instance/dio_factory.dart';
import 'package:sasuki/data/responses/acl_permission_group_list_responses/acl_permission_group_list_responses.dart';
import 'package:sasuki/data/responses/activate_method_responses/activate_method_responses.dart';
import 'package:sasuki/data/responses/activation_informs_responses/activation_informs_responses.dart';
import 'package:sasuki/data/responses/activations_reports_responses/activations_reports_responses.dart';
import 'package:sasuki/data/responses/captcha_responses/captcha_responses.dart';
import 'package:sasuki/data/responses/dashboard_responses/dashboard_data_responses.dart';
import 'package:sasuki/data/responses/dashboard_responses/auth_responses.dart';
import 'package:sasuki/data/responses/extend_user_informs_responses/extend_user_informs_responses.dart';
import 'package:sasuki/data/responses/extend_user_informs_responses/allowed_extersion_methods_responses.dart';
import 'package:sasuki/data/responses/filter_lists_responses/profile_list.dart';
import 'package:sasuki/data/responses/filter_lists_responses/parent_list.dart';
import 'package:sasuki/data/responses/login_responses/login_responses.dart';
import 'package:sasuki/data/responses/manager_action_response/manager_action_response.dart';
import 'package:sasuki/data/responses/manager_details_responses/manager_details_responses.dart';
import 'package:sasuki/data/responses/manager_details_responses/manager_overview_api_responses.dart';
import 'package:sasuki/data/responses/manager_journal_responses/manager_journal_responses.dart';
import 'package:sasuki/data/responses/manager_list_details_responses/security_group_responses.dart';
import 'package:sasuki/data/responses/managers_invoices_responses/managers_invoices_responses.dart';
import 'package:sasuki/data/responses/managers_list_responses/managers_list_responses.dart';
import 'package:sasuki/data/responses/manager_list_details_responses/manager_list_details_responses.dart';
import 'package:sasuki/data/responses/paydebt_informs_responses/paydebt_informs_responses.dart';
import 'package:sasuki/data/responses/user_action_response/user_action_response.dart';
import 'package:sasuki/data/responses/user_details_responses/user_overview_api_responses.dart';
import 'package:sasuki/data/responses/user_details_responses/user_api_responses.dart';
import 'package:sasuki/data/responses/users_list_responses/users_list_responses.dart';
import 'package:sasuki/presentation/login/viewmodel/login_viewmodel.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<LoginResponse> login(String payload) async {
    return await _appServiceClient.login(payload);
  }

  @override
  Future<CaptchaResponses> isCaptchaRequired() async {
    Dio dio = await instance<DioFactory>().getDio();
    _appServiceClient = AppServiceClient(
      dio,
      baseUrl:
          "https://${(await getSelectedServerFromLocal()).hostName}/${Constants.suffixUrl}",
    );

    return await _appServiceClient.isCaptchaRequired();
  }

  @override
  Future<ResponseCaptcha> getCaptcha(String sessionId) async {
    return await _appServiceClient.getCaptcha(sessionId);
  }

  @override
  Future<AuthResponses> getAuth() async {
    return await _appServiceClient.getAuth();
  }

  @override
  Future<DashboardResponse> getDashboardData() async {
    if (token != Constants.nullValue) {
      Dio dio = await instance<DioFactory>().getDio();
      _appServiceClient = AppServiceClient(
        dio,
        baseUrl:
            "https://${(await getSelectedServerFromLocal()).hostName}/${Constants.suffixUrl}",
      );
    }
    return await _appServiceClient.getDashboardData();
  }

  @override
  Future<UsersListResponse> getUsersList(String payload) async {
    return await _appServiceClient.getUsersList(payload);
  }

  @override
  Future<List<SingleParentDataResponses>> getParentList() async {
    return await _appServiceClient.getParentList();
  }

  @override
  Future<ProfileListResponses> getProfileList() async {
    return await _appServiceClient.getProfileList();
  }

  @override
  Future<UserApiResponse> getUserApi(int userId) async {
    return await _appServiceClient.getUserApi(userId);
  }

  @override
  Future<UserOverviewApiResponse> getUserOverviewApi(int userId) async {
    return await _appServiceClient.getUserOverviewApi(userId);
  }

  @override
  Future<UserActionResponse> deleteUser(int userId) async {
    return await _appServiceClient.deleteUser(userId);
  }

  @override
  Future<UserActionResponse> renameUser(String payload, int userId) async {
    return await _appServiceClient.renameUser(payload, userId);
  }

  @override
  Future<UserActionResponse> changeUserProfile(String payload) async {
    return await _appServiceClient.changeUserProfile(payload);
  }

  @override
  Future<ActivationInformsResponse> getActivationInforms(int userId) async {
    return await _appServiceClient.getActivationInforms(userId);
  }

  @override
  Future<ActivateMethodResponse> activateUser(String payload) async {
    return await _appServiceClient.activateUser(payload);
  }

  @override
  Future<UserActionResponse> addUser(String payload) async {
    return await _appServiceClient.addUser(payload);
  }

  @override
  Future<EditUserResponse> editUser(String payload, int userId) async {
    return await _appServiceClient.editUser(userId, payload);
  }

  @override
  Future<UserActionResponse> extendUser(String payload) async {
    return await _appServiceClient.extendUser(payload);
  }

  @override
  Future<ExtendUserInformsResponses> extendUserInforms(int userId) async {
    return await _appServiceClient.extendUserInforms(userId);
  }

  @override
  Future<AllowedExtersionMethodsResponses> getAllowedExtensions(
      int profileId) async {
    return await _appServiceClient.getAllowedExtensions(profileId);
  }

  @override
  Future<UserActionResponse> deposit(String payload) async {
    return await _appServiceClient.deposit(payload);
  }

  @override
  Future<UserActionResponse> withdraw(String payload) async {
    return await _appServiceClient.withdraw(payload);
  }

  @override
  Future<PaydebtInformsResponses> getPayDebtInforms(int userId) async {
    return await _appServiceClient.getPayDebtInforms(userId);
  }

  @override
  Future<UserActionResponse> payDebt(String payload) async {
    return await _appServiceClient.payDebt(payload);
  }

  @override
  Future<ManagersListResponses> getManagersList() async {
    return await _appServiceClient.getManagersList();
  }

  @override
  Future<ManagerListDetailsResponses> getManagersListDetails(
      String payload) async {
    return await _appServiceClient.getManagersListDetails(payload);
  }

  @override
  Future<ManagerOverviewApiResponses> getManagerOverviewApi(
      int managerId) async {
    return await _appServiceClient.getManagerOverviewApi(managerId);
  }

  @override
  Future<ManagerActionResponse> deleteManager(int managerId) async {
    return await _appServiceClient.deleteManager(managerId);
  }

  @override
  Future<ManagerActionResponse> renameManager(
      String payload, int managerId) async {
    return await _appServiceClient.renameManager(
      payload,
      managerId,
    );
  }

  @override
  Future<ManagerActionResponse> depositManager(String payload) async {
    return await _appServiceClient.depositManager(payload);
  }

  @override
  Future<ManagerActionResponse> withdrawManager(String payload) async {
    return await _appServiceClient.withdrawManager(payload);
  }

  @override
  Future<ManagerActionResponse> paydebtManager(String payload) async {
    return await _appServiceClient.paydebtManager(payload);
  }

  @override
  Future<ManagerActionResponse> addRewardPointsManager(String payload) async {
    return await _appServiceClient.addRewardPointsManager(payload);
  }

  @override
  Future<SecurityGroupResponses> getSecurityGroupList() async {
    return await _appServiceClient.getSecurityGroupList();
  }

  @override
  Future<EditUserResponse> addManager(String payload) async {
    return await _appServiceClient.addManager(payload);
  }

  @override
  Future<UserActionResponse> editManager(String payload, int managerId) async {
    return await _appServiceClient.editManager(managerId, payload);
  }

  @override
  Future<AclPermissionGroupListResponses> getAclPermissionGroupList() async {
    return await _appServiceClient.getAclPermissionGroupList();
  }

  @override
  Future<ManagerDetailsResponses> getManagerDetails(int managerId) async {
    return await _appServiceClient.getManageDetails(managerId);
  }

  @override
  Future<ActivationsReportsResponse> getActivationsReports(
    String payload,
  ) async {
    return await _appServiceClient.getActivationsReports(payload);
  }

  @override
  Future<ManagersInvoicesResponses> getManagerInvoices(String payload) async {
    return await _appServiceClient.getManagerInvoices(payload);
  }

  @override
  Future<ManagerJournalResponses> getManagerJournal(String payload) async {
    return await _appServiceClient.getManagerJournal(payload);
  }
}
