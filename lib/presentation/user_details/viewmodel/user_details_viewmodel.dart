import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_status_vals.dart';
import 'package:sasuki/data/network/models/change_profile_request.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/paydebt_informs/paydebt_informs.dart';
import 'package:sasuki/domain/models/user_action/user_action.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/domain/models/user_details/user_api.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/deposit_usecase/deposit_usecase.dart';
import 'package:sasuki/domain/usecase/deposit_usecase/withdraw_usecase.dart';
import 'package:sasuki/domain/usecase/paydebt_usecases/paydebt_informs_usecase.dart';
import 'package:sasuki/domain/usecase/paydebt_usecases/paydebt_method_usecase.dart';
import 'package:sasuki/domain/usecase/user_actions_usecases/change_user_profile_usecase.dart';
import 'package:sasuki/domain/usecase/user_actions_usecases/deleted_user_usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/domain/usecase/user_actions_usecases/renamed_user_usecase.dart';
import 'package:sasuki/domain/usecase/user_details_usecases/user_details__overviewapi_usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel_inputs.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel_outputs.dart';
import 'package:sasuki/presentation/users_list/viewmodel/users_list_viewmodel.dart';
import 'package:uuid/uuid.dart';

class UserDetailsViewModel extends BaseViewModel
    with UserDetailsViewModelInputs, UserDetailsViewModelOutputs {
  final UserOverviewApiUseCase _userOverviewApiUseCase;
  final AuthUseCase _authUseCase;
  final ProfileListUseCase _profileListUseCase;
  final DeletedUserUseCase _deletedUserUseCase;
  final RenamedUserUseCase _renamedUserUseCase;
  final ChangeUserProfileUseCase _changeUserProfileUseCase;
  final DepositUsecase _depositUsecase;
  final WithdrawUsecase _withdrawUsecase;
  final PaydebtUseCase _payDebtUsecase;
  final PayDebtInformsUsecase _payDebtInformsUsecase;
  final UsersListViewModel _usersListViewModel = instance<UsersListViewModel>();
  DepositWithdrawUserRequestObject depositWithdrawUserRequestObject =
      DepositWithdrawUserRequestObject(
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.emptyStr,
  );

  PayDebtRequestObject payDebtRequestObject = PayDebtRequestObject(
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.nullValue,
    Constants.falseBool,
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
  );

  UserDetailsViewModel(
    this._userOverviewApiUseCase,
    this._authUseCase,
    this._deletedUserUseCase,
    this._renamedUserUseCase,
    this._profileListUseCase,
    this._changeUserProfileUseCase,
    this._depositUsecase,
    this._withdrawUsecase,
    this._payDebtUsecase,
    this._payDebtInformsUsecase,
  );
  UserApi? userApiVar;
  String? newUsername;
  UserOverviewApi? userOverviewApiVar;
  PaydebtInforms? paydebtInforms;
  int? commingUserId;
  List<CardElement> listOfUserInforms(UserOverviewApi? userOverviewApi) => [
        CardElement(
          AppStrings.userOverviewusername,
          userOverviewApi?.data?.username ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewFullName,
          "${userOverviewApi?.data?.firstname ?? Constants.none} ${userOverviewApi?.data?.lastname ?? Constants.emptyStr}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewProfile,
          userOverviewApi?.data?.profileName ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewPassword,
          userOverviewApi?.data?.password ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewowner,
          userOverviewApi?.data?.parentUsername ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewExpirationDate,
          userOverviewApi?.data?.expiration ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewEmail,
          userOverviewApi?.data?.email ?? Constants.none,
          Constants.emptyStr,
        ),
      ];

  List<CardElement> listOfServiceInforms(UserOverviewApi? userOverviewApi) => [
        CardElement(
          AppStrings.userOverviewStatus,
          getStatusString(userOverviewApi?.data?.status),
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewRemainingTraffic,
          "${userOverviewApi?.data?.remainingRxtx ?? Constants.zeroNum.toInt()}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewRemainingDownload,
          "${userOverviewApi?.data?.remainingRx ?? Constants.zeroNum.toInt()}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewRemainingUpload,
          "${userOverviewApi?.data?.remainingTx ?? Constants.zeroNum.toInt()}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewRemainingUptime,
          "${userOverviewApi?.data?.remainingUptime ?? Constants.zeroNum.toInt()}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewLastLogin,
          userOverviewApi?.data?.lastOnline ?? Constants.none,
          Constants.emptyStr,
        ),
      ];

  List<SingleUserAction> userActions = [];
  @override
  void start() {}

  @override
  void dispose() {}

  @override
  getUserApiOverview(int userId) async {
    commingUserId = userId;
    _getAuth();
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.userDetails,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    return (await _userOverviewApiUseCase.execute(userId)).fold(
      (failure) {
        // left -> failure
        debugPrint("getUserApiOverview failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (userOverviewApi0) async {
        // right -> success (data)
        userOverviewApiVar = userOverviewApi0;
        getPayDebtInforms();
        if (!_userOverviewApiController.isClosed) {
          inputUserApiOverview.add(userOverviewApiVar);
        }
        inputState.add(ContentState());
      },
    );
  }

  _getAuth() async {
    // ignore: void_checks
    return (await _authUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getAuth failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (auth0) {
        // right -> success (data)
        userActions = [];
        _getPermissionsList(auth0.permissions);
      },
    );
  }

  void _getPermissionsList(List<String> permissions) {
    // for (var singlePerm in permissions) {
    if (permissions.contains(AppStrings.userPermissionEdit)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionEdit,
          IconsAssets.editUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionRename)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionRename,
          IconsAssets.checkUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionActivate)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionActivate,
          IconsAssets.tickcircleUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionExtend)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionExtend,
          IconsAssets.maximizecircleUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionChangeProfile)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionChangeProfile,
          IconsAssets.profileUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionDeposit)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionDeposit,
          IconsAssets.arrowrightUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionWithdrawal)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionWithdrawal,
          IconsAssets.arrowleftUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionPay)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionPay,
          IconsAssets.moneyUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.userPermissionDelete)) {
      userActions.add(
        SingleUserAction(
          AppStrings.userActionDelete,
          IconsAssets.trashUserAction,
        ),
      );
    }
  }

  @override
  getUserDataStreamingly() async {
    return (await _userOverviewApiUseCase.execute(commingUserId!)).fold(
      (failure) {
        // left -> failure
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        debugPrint("getUserDataStreamingly failure = ${failure.message}");
      },
      (userOverviewApi0) async {
        // right -> success (data)
        debugPrint("userOverviewApi0 = ${userOverviewApi0.status}");
        userOverviewApiVar = userOverviewApi0;
        getPayDebtInforms();
        inputUserApiOverview.add(userOverviewApiVar);
        // inputState.add(ContentState());
      },
    );
  }

  final StreamController _userOverviewApiController =
      StreamController<UserOverviewApi>.broadcast();
  @override
  Sink get inputUserApiOverview => _userOverviewApiController.sink;
  @override
  Stream<UserOverviewApi> get outputUserOverviewApi =>
      _userOverviewApiController.stream.map(
        (userOverviewApi) => userOverviewApi,
      );

  @override
  deleteUser(context) async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _deletedUserUseCase.execute(commingUserId!)).fold(
      (failure) {
        // left -> failure
        debugPrint("deleteUser failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (userOverviewApi0) async {
        // right -> success (data)
        // inputState.add(
        //   LoadingState(
        //     stateRendererType: StateRendererType.popupSuccessState,
        //   ),
        // );
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.userDeletedSuccess,
          ),
        );
      },
    );
  }

  @override
  renameUsername(String newUsername) async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _renamedUserUseCase.execute([newUsername, commingUserId]))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("renameUsername failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (userOverviewApi0) async {
        // right -> success (data)
        getUserDataStreamingly();
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.userRenamedSuccess,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  @override
  Future getProfileList() async {
    // ignore: void_checks
    return (await _profileListUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getProfileList failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (profileList0) async {
        // right -> success (data)
        List<ProfileData> profileList = [];
        profileList.add(
          ProfileData(Constants.minusOne, AppStrings.usersParentHint),
        );
        debugPrint("getProfileList = ${profileList0.data.length}");
        profileList.addAll(profileList0.data);
        inputProfileList.add(profileList);
      },
    );
  }

  @override
  changeProfile(int? profileId) async {
    debugPrint("profileId = $profileId");
    ChangeProfileRequest changeProfileRequest = ChangeProfileRequest(
      "$commingUserId",
      profileId,
      AppStrings.changeProfileDefaultValue,
    );

    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _changeUserProfileUseCase.execute(changeProfileRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("renameUsername failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (userOverviewApi0) async {
        // right -> success (data)
        getUserDataStreamingly();
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.userProfileChangedSuccess,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  ///
  final StreamController _getProfileListController =
      StreamController<List<ProfileData>>.broadcast();
  @override
  Sink get inputProfileList => _getProfileListController.sink;
  @override
  Stream<List<ProfileData>> get outputProfileList =>
      _getProfileListController.stream.map((profileList) => profileList);

  @override
  depositAction(String amount, String comment) async {
    depositWithdrawUserRequestObject =
        depositWithdrawUserRequestObject.copyWith(
      userId: "$commingUserId",
      userUsername: userOverviewApiVar?.data?.username,
      amount: int.parse(amount),
      comment: comment,
      transactionId: const Uuid().v1(),
    );
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _depositUsecase.execute(depositWithdrawUserRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("depositAction failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (UserAction userAction) async {
        // right -> success (data)
        getUserDataStreamingly();
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.amountAddedSuccessfully,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  @override
  withdrawAction(String amount, String comment) async {
    depositWithdrawUserRequestObject =
        depositWithdrawUserRequestObject.copyWith(
      userId: "$commingUserId",
      userUsername: userOverviewApiVar?.data?.username,
      amount: int.parse(amount),
      comment: comment,
      transactionId: const Uuid().v1(),
    );
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _withdrawUsecase.execute(depositWithdrawUserRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("withdrawAction failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (UserAction userAction) async {
        // right -> success (data)
        getUserDataStreamingly();
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.amountDeductedSuccessfully,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  @override
  getPayDebtInforms() async {
    return (await _payDebtInformsUsecase.execute(commingUserId!)).fold(
      (failure) {
        // left -> failure
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        debugPrint("getPayDebtInforms failure = ${failure.message}");
      },
      (paydebtInforms0) async {
        // right -> success (data)
        debugPrint(
          "paydebtInforms0?.data?.debtForMe = ${paydebtInforms0.data?.debtForMe}",
        );
        debugPrint(
          "@paydebtInforms0?.data?.debtForMe = ${paydebtInforms0.data?.debtForMe}",
        );

        debugPrint("paydebtInforms0 = ${paydebtInforms0.status}");
        paydebtInforms = paydebtInforms0;
        inputUserApiOverview.add(userOverviewApiVar);
        // inputState.add(ContentState());
      },
    );
  }

  @override
  payDebtAction(String amount, String comment) async {
    debugPrint(
      "paydebtInforms?.data?.debtForMe = ${paydebtInforms?.data?.debtForMe}",
    );
    payDebtRequestObject = payDebtRequestObject.copyWith(
      userId: commingUserId,
      username: userOverviewApiVar?.data?.username,
      amount: int.parse(amount),
      comment: comment,
      debtForMe: paydebtInforms?.data?.debtForMe,
      debt: paydebtInforms?.data?.debtForMe,
    );
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _payDebtUsecase.execute(payDebtRequestObject)).fold(
      (failure) {
        // left -> failure
        debugPrint("payDebtAction failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (UserAction userAction) async {
        // right -> success (data)
        getUserDataStreamingly();
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.changeAppliedSuccessfully,
          ),
        );
        paydebtInforms = Constants.nullValue;
        payDebtRequestObject = PayDebtRequestObject(
          Constants.zeroNum.toInt(),
          Constants.emptyStr,
          Constants.zeroNum.toInt(),
          Constants.emptyStr,
          Constants.nullValue,
          Constants.falseBool,
          Constants.zeroNum.toInt(),
          Constants.zeroNum.toInt(),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }
}

class SingleUserAction {
  final String? text;
  final String? icon;
  SingleUserAction(
    this.text,
    this.icon,
  );
}
