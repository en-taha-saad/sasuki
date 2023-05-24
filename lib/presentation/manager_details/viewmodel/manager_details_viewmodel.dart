import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';
import 'package:sasuki/domain/models/manager_action/manager_action.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/manager_actions_usecases/deleted_manager_usecase.dart';
import 'package:sasuki/domain/usecase/manager_actions_usecases/deposit_manager_usecase.dart';
import 'package:sasuki/domain/usecase/manager_actions_usecases/renamed_manager_usecase.dart';
import 'package:sasuki/domain/usecase/manager_details_usecases/manager_details__overviewapi_usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/manager_details/viewmodel/manager_details_viewmodel_inputs.dart';
import 'package:sasuki/presentation/manager_details/viewmodel/manager_details_viewmodel_outputs.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart' as intl;

class ManagerDetailsViewModel extends BaseViewModel
    with ManagerDetailsViewModelInputs, ManagerDetailsViewModelOutputs {
  final ManagerOverviewApiUseCase _managerOverviewApiUseCase;
  final DepositManagerUsecase _depositManagerUsecase;
  final WithdrawManagerUsecase _withdrawUsecase;
  final RenamedManagerUseCase _renamedManagerUseCase;
  final DeletedManagerUseCase _deletedManagerUseCase;
  final AuthUseCase _authUseCase;
  final CaptchaUseCase? _captchaUseCase;

  ManagerDetailsViewModel(
    this._managerOverviewApiUseCase,
    this._depositManagerUsecase,
    this._withdrawUsecase,
    this._renamedManagerUseCase,
    this._deletedManagerUseCase,
    this._authUseCase,
    this._captchaUseCase,
  );

  final ManagersListViewModel _managersListViewModel =
      instance<ManagersListViewModel>();

  DepositWithdrawPayDebtManagerRequestObject
      depositWithdrawManagerRequestObject =
      DepositWithdrawPayDebtManagerRequestObject(
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.falseBool,
  );

  String? newUsername;
  double? upperBalance = Constants.zeroNum;
  String? upperUsername = Constants.emptyStr;
  Captcha? dataCaptcha;
  ManagerOverviewApi? managerOverviewApiVar;
  int? commingManagerId;

  List<CardElement> listOfManagerInforms(
    ManagerOverviewApi? managerOverviewApi,
  ) =>
      [
        CardElement(
          AppStrings.userOverviewusername,
          managerOverviewApi?.data?.username ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewFullName,
          "${managerOverviewApi?.data?.firstname ?? Constants.none} ${managerOverviewApi?.data?.lastname ?? Constants.emptyStr}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.managerPermissionGroup,
          managerOverviewApi?.data?.aclGroupName ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewowner,
          managerOverviewApi?.data?.parentUsername ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.managerBalance,
          "${dataCaptcha?.data?.siteCurrency} ${intl.NumberFormat.decimalPattern().format(managerOverviewApi?.data?.balance ?? Constants.zeroNum)}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userExtendRewardPoints,
          managerOverviewApi?.data?.rewardPoints.toString() ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.usersStatus,
          managerOverviewApi?.data?.status == Constants.zeroNum
              ? AppStrings.disabledManager
              : AppStrings.enabledManager,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.totalUsers,
          managerOverviewApi?.data?.users.toString() ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.dashboardActiveUsers,
          managerOverviewApi?.data?.activeUsers.toString() ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.dashboardExpiredUsers,
          managerOverviewApi?.data?.expiredUsers.toString() ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userPhoneHint,
          managerOverviewApi?.data?.phone.toString() ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.managerOverviewCreationDate,
          managerOverviewApi?.data?.createdAt.toString() ?? Constants.none,
          Constants.emptyStr,
        ),
      ];

  List<SingleManagerAction> managerActions = [];
  @override
  void start() {}

  @override
  void dispose() {}

  @override
  getManagerApiOverview(int managerId) async {
    commingManagerId = managerId;
    _getAuth();
    _getCaptchaResponse();
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.managerDetails,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    return (await _managerOverviewApiUseCase.execute(managerId)).fold(
      (failure) {
        // left -> failure
        debugPrint("getManagerApiOverview failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
      (managerOverviewApi0) async {
        // right -> success (data)
        managerOverviewApiVar = managerOverviewApi0;
        if (!_managerOverviewApiController.isClosed) {
          inputManagerApiOverview.add(managerOverviewApiVar);
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
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
      (auth0) {
        // right -> success (data)
        managerActions = [];
        upperUsername = auth0.client?.username;
        upperBalance = auth0.client?.balance;

        _getPermissionsList(auth0.permissions);
      },
    );
  }

  void _getPermissionsList(List<String> permissions) {
    // for (var singlePerm in permissions) {
    if (permissions.contains(AppStrings.managerPermissionEdit)) {
      managerActions.add(
        SingleManagerAction(
          AppStrings.managerActionEdit,
          IconsAssets.editUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.managerPermissionRename)) {
      managerActions.add(
        SingleManagerAction(
          AppStrings.managerActionRename,
          IconsAssets.checkUserAction,
        ),
      );
    }

    if (permissions.contains(AppStrings.managerPermissionDeposit)) {
      managerActions.add(
        SingleManagerAction(
          AppStrings.managerActionDeposit,
          IconsAssets.arrowrightUserAction,
        ),
      );
    }
    if (permissions.contains(AppStrings.managerPermissionWithdrawal)) {
      managerActions.add(
        SingleManagerAction(
          AppStrings.managerActionWithdrawal,
          IconsAssets.arrowleftUserAction,
        ),
      );
    }

    if (permissions.contains(AppStrings.managerPermissionDelete)) {
      managerActions.add(
        SingleManagerAction(
          AppStrings.managerActionDelete,
          IconsAssets.trashUserAction,
        ),
      );
    }
  }

  @override
  getManagerDataStreamingly() async {
    return (await _managerOverviewApiUseCase.execute(commingManagerId!)).fold(
      (failure) {
        // left -> failure
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
        debugPrint("getManagerDataStreamingly failure = ${failure.message}");
      },
      (managerOverviewApi0) async {
        // right -> success (data)
        debugPrint("managerOverviewApi0 = ${managerOverviewApi0.status}");
        managerOverviewApiVar = managerOverviewApi0;
        inputManagerApiOverview.add(managerOverviewApiVar);
        // inputState.add(ContentState());
      },
    );
  }

  final StreamController _managerOverviewApiController =
      StreamController<ManagerOverviewApi>.broadcast();
  @override
  Sink get inputManagerApiOverview => _managerOverviewApiController.sink;
  @override
  Stream<ManagerOverviewApi> get outputManagerOverviewApi =>
      _managerOverviewApiController.stream.map(
        (managerOverviewApi) => managerOverviewApi,
      );

  @override
  deleteManager(context) async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _deletedManagerUseCase.execute(commingManagerId!)).fold(
      (failure) {
        // left -> failure
        debugPrint("deleteManager failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
      (managerOverviewApi0) async {
        // right -> success (data)
        // inputState.add(
        //   LoadingState(
        //     stateRendererType: StateRendererType.popupSuccessState,
        //   ),
        // );
        _managersListViewModel.refreshManagersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.managerDeletedSuccess,
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
    return (await _renamedManagerUseCase
            .execute([newUsername, commingManagerId]))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("renameManagername failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
      (managerOverviewApi0) async {
        // right -> success (data)
        getManagerDataStreamingly();
        _managersListViewModel.refreshManagersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.managerRenamedSuccess,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  @override
  depositAction(String amount, String comment, bool isLoan) async {
    depositWithdrawManagerRequestObject =
        depositWithdrawManagerRequestObject.copyWith(
      managerId: commingManagerId,
      isLoan: isLoan,
      managerUsername: managerOverviewApiVar?.data?.username,
      amount: int.parse(amount),
      comment: comment,
      transactionId: const Uuid().v1(),
    );
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _depositManagerUsecase
            .execute(depositWithdrawManagerRequestObject))
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
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
      (ManagerAction managerAction) async {
        // right -> success (data)
        getManagerDataStreamingly();
        _managersListViewModel.refreshManagersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.managerAmountAddedSuccessfully,
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
    depositWithdrawManagerRequestObject =
        depositWithdrawManagerRequestObject.copyWith(
      managerId: commingManagerId,
      managerUsername: managerOverviewApiVar?.data?.username,
      amount: int.parse(amount),
      comment: comment,
      transactionId: const Uuid().v1(),
    );
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    return (await _withdrawUsecase.execute(depositWithdrawManagerRequestObject))
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
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
      (ManagerAction managerAction) async {
        // right -> success (data)
        getManagerDataStreamingly();
        _managersListViewModel.refreshManagersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.managerAmountDeductedSuccessfully,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  _getCaptchaResponse() async {
    // ignore: void_checks
    return (await _captchaUseCase?.execute(Void))?.fold(
      (failure) {
        // left -> failure
        debugPrint("failure failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
      (Captcha dataCaptcha0) {
        // right -> success (data)
        dataCaptcha = dataCaptcha0;
        inputDataCaptcha.add(dataCaptcha);
      },
    );
  }

  final StreamController _captchaController =
      StreamController<Captcha>.broadcast();

  Sink get inputDataCaptcha => _captchaController.sink;
  Stream<Captcha> get outputDataCaptcha => _captchaController.stream.map(
        (captcha) => captcha,
      );
}

class SingleManagerAction {
  final String? text;
  final String? icon;
  SingleManagerAction(
    this.text,
    this.icon,
  );
}
