import 'package:sasuki/data/responses/acl_permission_group_list_responses/acl_permission_group_list_responses.dart';
import 'package:sasuki/data/responses/activate_method_responses/activate_method_responses.dart';
import 'package:sasuki/data/responses/activation_informs_responses/activation_informs_responses.dart';
import 'package:sasuki/data/responses/activations_reports_responses/activations_reports_responses.dart';
import 'package:sasuki/data/responses/activity_log_events_responses/activity_log_events_responses.dart';
import 'package:sasuki/data/responses/activity_log_list_responses/activity_log_list_responses.dart';
import 'package:sasuki/data/responses/captcha_responses/captcha_responses.dart';
import 'package:sasuki/data/responses/dashboard_responses/auth_responses.dart';
import 'package:sasuki/data/responses/dashboard_responses/dashboard_data_responses.dart';
import 'package:sasuki/data/responses/extend_user_informs_responses/allowed_extersion_methods_responses.dart';
import 'package:sasuki/data/responses/extend_user_informs_responses/extend_user_informs_responses.dart';
import 'package:sasuki/data/responses/filter_lists_responses/parent_list.dart';
import 'package:sasuki/data/responses/filter_lists_responses/profile_list.dart';
import 'package:sasuki/data/responses/login_responses/login_responses.dart';
import 'package:sasuki/data/responses/manager_action_response/manager_action_response.dart';
import 'package:sasuki/data/responses/manager_details_responses/manager_details_responses.dart';
import 'package:sasuki/data/responses/manager_details_responses/manager_overview_api_responses.dart';
import 'package:sasuki/data/responses/manager_journal_responses/manager_journal_responses.dart';
import 'package:sasuki/data/responses/manager_list_details_responses/manager_list_details_responses.dart';
import 'package:sasuki/data/responses/manager_list_details_responses/security_group_responses.dart';
import 'package:sasuki/data/responses/managers_invoices_responses/managers_invoices_responses.dart';
import 'package:sasuki/data/responses/managers_list_responses/managers_list_responses.dart';
import 'package:sasuki/data/responses/paydebt_informs_responses/paydebt_informs_responses.dart';
import 'package:sasuki/data/responses/payment_methods_responses/deposit_action_responses.dart';
import 'package:sasuki/data/responses/payment_methods_responses/payment_methods_responses.dart';
import 'package:sasuki/data/responses/user_action_response/user_action_response.dart';
import 'package:sasuki/data/responses/user_details_responses/user_api_responses.dart';
import 'package:sasuki/data/responses/user_details_responses/user_overview_api_responses.dart';
import 'package:sasuki/data/responses/users_list_responses/users_list_responses.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(String payload);
  Future<CaptchaResponses> isCaptchaRequired();
  Future<ResponseCaptcha> getCaptcha(String sessionId);
  Future<AuthResponses> getAuth();
  Future<DashboardResponse> getDashboardData();
  Future<UsersListResponse> getUsersList(String payload);
  Future<List<SingleParentDataResponses>> getParentList();
  Future<ProfileListResponses> getProfileList();
  Future<UserApiResponse> getUserApi(int userId);
  Future<UserOverviewApiResponse> getUserOverviewApi(int userId);
  Future<UserActionResponse> deleteUser(int userId);
  Future<UserActionResponse> renameUser(String payload, int userId);
  Future<UserActionResponse> changeUserProfile(String payload);
  Future<ActivationInformsResponse> getActivationInforms(int userId);
  Future<ActivateMethodResponse> activateUser(String payload);
  Future<UserActionResponse> addUser(String payload);
  Future<EditUserResponse> editUser(String payload, int userId);
  Future<ExtendUserInformsResponses> extendUserInforms(int userId);
  Future<AllowedExtersionMethodsResponses> getAllowedExtensions(int profileId);
  Future<UserActionResponse> extendUser(String payload);
  Future<UserActionResponse> deposit(String payload);
  Future<UserActionResponse> withdraw(String payload);
  Future<PaydebtInformsResponses> getPayDebtInforms(int userId);
  Future<UserActionResponse> payDebt(String payload);
  Future<ManagersListResponses> getManagersList();
  Future<AclPermissionGroupListResponses> getAclPermissionGroupList();
  Future<ManagerListDetailsResponses> getManagersListDetails(String payload);
  Future<ManagerOverviewApiResponses> getManagerOverviewApi(int managerId);
  Future<ManagerActionResponse> deleteManager(int managerId);
  Future<ManagerActionResponse> renameManager(String payload, int managerId);
  Future<ManagerActionResponse> depositManager(String payload);
  Future<ManagerActionResponse> withdrawManager(String payload);
  Future<ManagerActionResponse> paydebtManager(String payload);
  Future<ManagerActionResponse> addRewardPointsManager(String payload);
  Future<SecurityGroupResponses> getSecurityGroupList();
  Future<EditUserResponse> addManager(String payload);
  Future<UserActionResponse> editManager(String payload, int managerId);
  Future<ManagerDetailsResponses> getManagerDetails(int managerId);
  Future<ActivationsReportsResponse> getActivationsReports(
    String payload,
  );

  Future<ManagersInvoicesResponses> getManagerInvoices(
    String payload,
  );

  Future<ManagerJournalResponses> getManagerJournal(
    String payload,
  );

  Future<DepositActionResponse> depositPayment(String payload);

  Future<PaymentMethodsResponses> getPaymentMethods();

  Future<ActivityLogListResponses> getActivityLogList(String payload);

  Future<ActivityLogEventsResponses> getActivityLogEvent();
}
