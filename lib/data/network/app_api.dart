import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sasuki/data/responses/acl_permission_group_list_responses/acl_permission_group_list_responses.dart';
import 'package:sasuki/data/responses/activate_method_responses/activate_method_responses.dart';
import 'package:sasuki/data/responses/activation_informs_responses/activation_informs_responses.dart';
import 'package:sasuki/data/responses/activations_reports_responses/activations_reports_responses.dart';
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
part 'app_api.g.dart';

@RestApi(baseUrl: "{baseUrl}")
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/login")
  Future<LoginResponse> login(@Field("payload") String payload);

  @GET("/resources/login")
  Future<CaptchaResponses> isCaptchaRequired();

  @GET("/login/captcha/{sessionId}")
  Future<ResponseCaptcha> getCaptcha(@Path("sessionId") String sessionId);

  @GET("/auth")
  Future<AuthResponses> getAuth();

  @GET("/mobile/dashboard")
  Future<DashboardResponse> getDashboardData();

  @POST("/index/user")
  Future<UsersListResponse> getUsersList(@Field("payload") String payload);

  @GET("/manager/tree")
  Future<List<SingleParentDataResponses>> getParentList();

  @GET("/list/profile/0")
  Future<ProfileListResponses> getProfileList();

  @GET("/user/{userId}")
  Future<UserApiResponse> getUserApi(@Path("userId") int userId);

  @GET("/user/overview/{userId}")
  Future<UserOverviewApiResponse> getUserOverviewApi(
    @Path("userId") int userId,
  );

  @DELETE("/user/{userId}")
  Future<UserActionResponse> deleteUser(@Path("userId") int userId);

  @POST("/user/rename/{userId}")
  Future<UserActionResponse> renameUser(
    @Field("payload") String payload,
    @Path("userId") int userId,
  );

  @POST("/user/changeProfile")
  Future<UserActionResponse> changeUserProfile(
      @Field("payload") String payload);

  @GET("/user/activationData/{userId}")
  Future<ActivationInformsResponse> getActivationInforms(
    @Path("userId") int userId,
  );

  @POST("/user/activate")
  Future<ActivateMethodResponse> activateUser(
    @Field("payload") String payload,
  );

  @POST("/user")
  Future<UserActionResponse> addUser(@Field("payload") String payload);

  @PUT("/user/{userId}")
  Future<EditUserResponse> editUser(
    @Path("userId") int userId,
    @Field("payload") String payload,
  );

  @GET("/user/extensionData/{userId}")
  Future<ExtendUserInformsResponses> extendUserInforms(
    @Path("userId") int userId,
  );

  @GET("/allowedExtensions/{profileId}")
  Future<AllowedExtersionMethodsResponses> getAllowedExtensions(
    @Path("profileId") int profileId,
  );

  @POST("/user/extend")
  Future<UserActionResponse> extendUser(
    @Field("payload") String payload,
  );

  @POST("/user/deposit")
  Future<UserActionResponse> deposit(
    @Field("payload") String payload,
  );

  @POST("/user/withdraw")
  Future<UserActionResponse> withdraw(
    @Field("payload") String payload,
  );

  @GET("/user/debt/{userId}")
  Future<PaydebtInformsResponses> getPayDebtInforms(
    @Path("userId") int userId,
  );
  @POST("/user/payDebt")
  Future<UserActionResponse> payDebt(
    @Field("payload") String payload,
  );

  @GET("/index/manager")
  Future<ManagersListResponses> getManagersList();

  @GET("/index/acl")
  Future<AclPermissionGroupListResponses> getAclPermissionGroupList();

  @POST("/index/manager")
  Future<ManagerListDetailsResponses> getManagersListDetails(
    @Field("payload") String payload,
  );

  @GET("/manager/overview/{managerId}")
  Future<ManagerOverviewApiResponses> getManagerOverviewApi(
    @Path("managerId") int managerId,
  );

  @DELETE("/manager/{managerId}")
  Future<ManagerActionResponse> deleteManager(@Path("managerId") int managerId);

  @PUT("/manager/{managerId}")
  Future<ManagerActionResponse> renameManager(
    @Field("payload") String payload,
    @Path("managerId") int managerId,
  );

  @POST("/manager/deposit")
  Future<ManagerActionResponse> depositManager(
    @Field("payload") String payload,
  );

  @POST("/manager/withdraw")
  Future<ManagerActionResponse> withdrawManager(
    @Field("payload") String payload,
  );

  @POST("/manager/payDebt")
  Future<ManagerActionResponse> paydebtManager(
    @Field("payload") String payload,
  );

  @POST("/manager/addRewardPoints")
  Future<ManagerActionResponse> addRewardPointsManager(
    @Field("payload") String payload,
  );

  @GET("/index/acl")
  Future<SecurityGroupResponses> getSecurityGroupList();

  @POST("/manager")
  Future<EditUserResponse> addManager(@Field("payload") String payload);

  @GET("/manager/{managerId}")
  Future<ManagerDetailsResponses> getManageDetails(
      @Path("managerId") int managerId);

  @PUT("/manager/{managerId}")
  Future<UserActionResponse> editManager(
    @Path("managerId") int managerId,
    @Field("payload") String payload,
  );

  @POST("/index/activations")
  Future<ActivationsReportsResponse> getActivationsReports(
    @Field("payload") String payload,
  );

  @POST("/index/ManagerInvoices")
  Future<ManagersInvoicesResponses> getManagerInvoices(
    @Field("payload") String payload,
  );

  @POST("/index/ManagerJournal")
  Future<ManagerJournalResponses> getManagerJournal(
    @Field("payload") String payload,
  );

  @POST("/paymentgateway/requestSelfDeposit")
  Future<DepositActionResponse> depositPayment(
    @Field("payload") String payload
  );


  @GET("/paymentgateway/list/acp")
  Future<PaymentMethodsResponses> getPaymentMethods();


}
