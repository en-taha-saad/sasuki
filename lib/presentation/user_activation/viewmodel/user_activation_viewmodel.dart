import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_status_vals.dart';
import 'package:sasuki/domain/models/activation_informs/activation_informs.dart';
import 'package:sasuki/domain/models/activation_informs/activation_method.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/domain/usecase/activate_method_usecase/activate_method_usecase.dart';
import 'package:sasuki/domain/usecase/user_activation_informs_usecase/user_activation_informs_usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/user_activation/viewmodel/user_activation_viewmodel_inputs.dart';
import 'package:sasuki/presentation/user_activation/viewmodel/user_activation_viewmodel_outputs.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';
import 'package:sasuki/presentation/users_list/viewmodel/users_list_viewmodel.dart';
import 'package:uuid/uuid.dart';

class UserActivationViewModel extends BaseViewModel
    with UserActivationViewModelInputs, UserActivationViewModelOutputs {
  final ActivationInformsUsecase _activationInformsUsecase;
  final ActivateMethodUseCase _activateMethodUseCase;

  UserActivationViewModel(
    this._activationInformsUsecase,
    this._activateMethodUseCase,
  );

  List<CardElement> listOfActivationInforms(
    UserOverviewApi? userOverviewApi,
    ActivationInforms? activationInforms,
  ) =>
      [
        CardElement(
          AppStrings.userOverviewusername,
          userOverviewApi?.data?.username ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewStatus,
          getStatusString(userOverviewApi?.data?.status),
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewFullName,
          "${userOverviewApi?.data?.firstname ?? Constants.none} ${userOverviewApi?.data?.lastname ?? Constants.emptyStr}",
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewExpirationDate,
          userOverviewApi?.data?.expiration ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewProfile,
          userOverviewApi?.data?.profileName ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userActivationCost,
          activationInforms?.data?.unitPrice ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userActivationManagerBalance,
          activationInforms?.data?.managerBalance ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userActivationMUserBalance,
          activationInforms?.data?.userBalance ?? Constants.none,
          Constants.emptyStr,
        ),
      ];

  final UserDetailsViewModel _userDetailsViewModel =
      instance<UserDetailsViewModel>();
  final UsersListViewModel _usersListViewModel = instance<UsersListViewModel>();

  ActivationRequestObject activationRequestObject = ActivationRequestObject(
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.falseBool,
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
  );
  @override
  void start() {}

  @override
  void dispose() {}

  @override
  getActivationInforms(int userId) async {
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.activationInforms,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    return (await _activationInformsUsecase.execute(userId)).fold(
      (failure) {
        // left -> failure
        debugPrint("getActivationInforms failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activationInforms0) async {
        // right -> success (data)
        debugPrint("activationInforms0 = $activationInforms0");
        inputActivationInforms.add(activationInforms0);
        inputState.add(ContentState());
      },
    );
  }

  @override
  getActivationInformsStreamingly(int userId) async {
    return (await _activationInformsUsecase.execute(userId)).fold(
      (failure) {
        // left -> failure
        debugPrint(
            "getActivationInformsStreamingly failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activationInforms0) async {
        // right -> success (data)
        debugPrint("activationInforms0 = $activationInforms0");
        inputActivationInforms.add(activationInforms0);
      },
    );
  }

  @override
  activateUser(
    ActivationMethod? selectedActivationMethod,
    bool isMoneyCollected,
    int? userPrice,
  ) async {
    debugPrint("userPrice = $userPrice");
    activationRequestObject = activationRequestObject.copyWith(
      method: selectedActivationMethod?.requiredSentString,
      moneyCollected: isMoneyCollected
          ? Constants.oneNum.toInt()
          : Constants.zeroNum.toInt(),
      activationUnits: Constants.oneNum.toInt(),
      issueInvoice: Constants.trueBool,
      transactionId: const Uuid().v1(),
      userPrice: userPrice,
      userId: "${_userDetailsViewModel.commingUserId}",
    );
    return (await _activateMethodUseCase.execute(activationRequestObject)).fold(
      (failure) {
        // left -> failure
        debugPrint("activateUser failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activateMethod) async {
        // right -> success (data)
        debugPrint("activateMethod = $activateMethod");
        getActivationInformsStreamingly(_userDetailsViewModel.commingUserId!);
        _userDetailsViewModel.getUserDataStreamingly();
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.userActivatedSuccessfully,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  @override
  setPin(String pin) {
    activationRequestObject = activationRequestObject.copyWith(pin: pin);
  }

  @override
  setComment(String comment) {
    activationRequestObject = activationRequestObject.copyWith(
      comments: comment,
    );
  }

  ///
  final StreamController _activationInformsController =
      StreamController<ActivationInforms>.broadcast();
  @override
  Sink get inputActivationInforms => _activationInformsController.sink;
  @override
  Stream<ActivationInforms> get outputActivationInforms =>
      _activationInformsController.stream.map(
        (activationInforms) => activationInforms,
      );
}
