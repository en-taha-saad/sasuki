import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/activation_informs/activation_method.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';
import 'package:sasuki/domain/models/extend_user_informs/allowed_extersion_methods.dart';
import 'package:sasuki/domain/models/extend_user_informs/extend_user_informs.dart';
import 'package:sasuki/domain/usecase/extend_user_informs_usecases/allowed_extensions_informs_usecase.dart';
import 'package:sasuki/domain/usecase/extend_user_informs_usecases/extend_user_informs_usecase.dart';
import 'package:sasuki/domain/usecase/extend_user_informs_usecases/extend_user_usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/extend_user/viewmodel/extend_user_viewmodel_inputs.dart';
import 'package:sasuki/presentation/extend_user/viewmodel/extend_user_viewmodel_outputs.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';
import 'package:sasuki/presentation/users_list/viewmodel/users_list_viewmodel.dart';
import 'package:uuid/uuid.dart';

class ExtendUserViewModel extends BaseViewModel
    with ExtendUserViewModelInputs, ExtendUserViewModelOutputs {
  final ExtendUserUsecase _extendUserUsecase;
  final ExtendUserInformsUsecase _extendUserInformsUsecase;
  final AllowedExtensionsUsecase _allowedExtensionsUsecase;

  ExtendUserViewModel(
    this._extendUserUsecase,
    this._extendUserInformsUsecase,
    this._allowedExtensionsUsecase,
  );

  List<CardElement> listOfExtendUserInforms(
    ExtendUserInforms? extendUserInforms,
  ) =>
      [
        CardElement(
          AppStrings.userOverviewusername,
          extendUserInforms?.data?.username ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewExpirationDate,
          extendUserInforms?.data?.expiration ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userOverviewProfile,
          extendUserInforms?.data?.profileName ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userActivationManagerBalance,
          extendUserInforms?.data?.balance ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userActivationMUserBalance,
          extendUserInforms?.data?.userBalance ?? Constants.none,
          Constants.emptyStr,
        ),
        CardElement(
          AppStrings.userExtendRewardPoints,
          "${extendUserInforms?.data?.rewardPoints ?? Constants.dash}",
          Constants.emptyStr,
        ),
      ];

  final UserDetailsViewModel _userDetailsViewModel =
      instance<UserDetailsViewModel>();
  final UsersListViewModel _usersListViewModel = instance<UsersListViewModel>();

  ExtendUserRequestObject extendUserRequestObject = ExtendUserRequestObject(
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
  );
  @override
  void start() {
  }

  @override
  void dispose() {
    _extendUserInformsController.close();
    _allowedExtensionsController.close();
    super.dispose();
  }

  @override
  getExtendUserInforms(int userId) async {
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.activationInforms,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    return (await _extendUserInformsUsecase.execute(userId)).fold(
      (failure) {
        // left -> failure
        debugPrint("getExtendUserInforms failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (extendUserInforms0) async {
        // right -> success (data)
        debugPrint("extendUserInforms0 = $extendUserInforms0");
        inputExtendUserInforms.add(extendUserInforms0);
        inputState.add(ContentState());
      },
    );
  }

  @override
  getExtendUserInformsStreamingly(int userId) async {
    return (await _extendUserInformsUsecase.execute(userId)).fold(
      (failure) {
        // left -> failure
        debugPrint(
            "getExtendUserInformsStreamingly failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (extendUserInforms0) async {
        // right -> success (data)
        debugPrint("extendUserInforms0 = $extendUserInforms0");
        inputExtendUserInforms.add(extendUserInforms0);
      },
    );
  }

  @override
  extendUser(
    ActivationMethod? selectedActivationMethod,
    int? extensionId,
  ) async {
    extendUserRequestObject = extendUserRequestObject.copyWith(
      method: selectedActivationMethod?.requiredSentString,
      transactionId: const Uuid().v1(),
      profileId: "$extensionId",
      userId: "${_userDetailsViewModel.commingUserId}",
    );
    return (await _extendUserUsecase.execute(extendUserRequestObject)).fold(
      (failure) {
        // left -> failure
        debugPrint("extendUser failure = ${failure.message}");
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
      (userAction) async {
        // right -> success (data)
        debugPrint("userAction = $userAction");
        getExtendUserInformsStreamingly(_userDetailsViewModel.commingUserId!);
        _userDetailsViewModel.getUserDataStreamingly();
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.userExtendedSuccessfully,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  @override
  getExtensionsInforms(int profileId) async {
    debugPrint("profileId = $profileId");

    return (await _allowedExtensionsUsecase.execute(profileId)).fold(
      (failure) {
        // left -> failure
        debugPrint("getExtensionsInforms failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (allowedExtersionMethods) async {
        // right -> success (data)
        List<Extension> extensionsList = [];
        extensionsList.addAll(allowedExtersionMethods.data!);
        inputExtensionInforms.add(
          AllowedExtersionMethods(
            allowedExtersionMethods.i0,
            allowedExtersionMethods.status,
            extensionsList,
          ),
        );
        debugPrint("allowedExtersionMethods = ${allowedExtersionMethods.data?.length}");
      },
    );
  }

  ///
  final StreamController _extendUserInformsController =
      StreamController<ExtendUserInforms>.broadcast();
  @override
  Sink get inputExtendUserInforms => _extendUserInformsController.sink;
  @override
  Stream<ExtendUserInforms> get outputExtendUserInforms =>
      _extendUserInformsController.stream.map(
        (extendUserInforms) => extendUserInforms,
      );

  ///
  final StreamController _allowedExtensionsController =
      StreamController<AllowedExtersionMethods>.broadcast();
  @override
  Sink get inputExtensionInforms => _allowedExtensionsController.sink;
  @override
  Stream<AllowedExtersionMethods> get outputExtensionInforms =>
      _allowedExtensionsController.stream.map(
        (activationInforms) => activationInforms,
      );
}
