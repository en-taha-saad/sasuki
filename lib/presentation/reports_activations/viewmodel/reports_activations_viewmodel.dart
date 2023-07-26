import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/usecase/activations_reports_usecase/activations_reports_usecase.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/reports_activations/viewmodel/reports_activations_viewmodel_inputs.dart';
import 'package:sasuki/presentation/reports_activations/viewmodel/reports_activations_viewmodel_outputs.dart';

class ReportsActivationsViewModel extends BaseViewModel
    with ReportsActivationsViewModelInputs, ReportsActivationsViewModelOutputs {
  final ActivationsReportsUsecase _activationsReportsUsecase;
  final ProfileListUseCase _profileListUseCase;
  final CaptchaUseCase? _captchaUseCase;
  int? totalActivations = 0;

  ReportsActivationsViewModel(
    this._activationsReportsUsecase,
    this._profileListUseCase,
    this._captchaUseCase,
  );

  ActivationReportsRequestObject activationReportsRequestObject =
      ActivationReportsRequestObject(
    Constants.oneNum.toInt(),
    Constants.twintyNum,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    [],
    Constants.minusOne.toInt(),
    Constants.oneNum.toInt(),
    Constants.minusOne.toInt(),
    Constants.minusOne.toInt(),
    "any",
    Constants.emptyStr,
    Constants.emptyStr,
  );
  ActivationsReports? activationsReports;
  int page = Constants.oneNum.toInt();
  Captcha? dataCaptcha;
  ActivationsReports? listOfActivations;

  @override
  void start() async {
    _getCaptchaResponse();

    await getReportsActivations();
  }

  @override
  void dispose() {}
  @override
  Future getReportsActivations() async {
    activationReportsRequestObject = activationReportsRequestObject.copyWith(
      profileId: Constants.minusOne,
    );
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.activationsReports,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    return (await _activationsReportsUsecase
            .execute(activationReportsRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("failure getUsersListData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activationsReports0) async {
        debugPrint(
            "getReportsActivations failure = ${activationsReports0.total}");
        // right -> success (data)
        activationsReports = activationsReports0;
        inputState.add(ContentState());
        inputReportsActivations.add(activationsReports);
        totalActivations = activationsReports?.total;
        getReportsActivationsForPull();
      },
    );
  }

  @override
  Future getNextReportsActivations() async {
    page == page++;

    activationReportsRequestObject =
        activationReportsRequestObject.copyWith(page: page);
    // ignore: void_checks
    return (await _activationsReportsUsecase
            .execute(activationReportsRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getNextReportsActivations failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activationsReports0) async {
        // right -> success (data)
        activationsReports = activationsReports0;
        listOfActivations?.data?.addAll((activationsReports?.data)!);
        inputReportsActivations.add(listOfActivations);
        totalActivations = activationsReports?.total;
        inputState.add(ContentState());
        // make function to get next page
        // getReportsActivationsForPull();
      },
    );
  }

  @override
  getActivationsReportsStreamingly() async {
    return (await _activationsReportsUsecase
            .execute(activationReportsRequestObject))
        .fold(
      (failure) {
        // left -> failure
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        debugPrint(
            "getActivationsReportsStreamingly failure = ${failure.message}");
      },
      (activationsReports0) async {
        // right -> success (data)
        activationsReports = activationsReports0;
        inputReportsActivations.add(activationsReports);
        // inputState.add(ContentState());
      },
    );
  }

  resetRequestArguments() {
    page = Constants.oneNum.toInt();
    listOfActivations = null;
    activationsReports = null;
    activationReportsRequestObject =
        activationReportsRequestObject.copyWith(page: page);
  }

  @override
  Future getReportsActivationsForPull() async {
    resetRequestArguments();
    // ignore: void_checks
    return (await _activationsReportsUsecase
            .execute(activationReportsRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getReportsActivationsForPull failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activationsReports0) async {
        // right -> success (data)
        activationsReports = activationsReports0;
        listOfActivations = activationsReports;
        inputReportsActivations.add(listOfActivations);
        inputState.add(ContentState());
      },
    );
  }

  ///
  final StreamController _reportsActivationsController =
      StreamController<ActivationsReports>.broadcast();
  @override
  Sink get inputReportsActivations => _reportsActivationsController.sink;

  @override
  Stream<ActivationsReports> get outputReportsActivations =>
      _reportsActivationsController.stream.map(
        (reportsActivations) => reportsActivations,
      );

  ///
  final StreamController _getProfileListController =
      StreamController<List<ProfileData>>.broadcast();
  @override
  Sink get inputProfileList => _getProfileListController.sink;
  @override
  Stream<List<ProfileData>> get outputProfileList =>
      _getProfileListController.stream.map((profileList) => profileList);
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
          ProfileData(Constants.minusOne, "Any"),
        );
        debugPrint("getProfileList = ${profileList0.data.length}");
        profileList.addAll(profileList0.data);
        inputProfileList.add(profileList);
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

  @override
  refreshReportsActivations() async {
    activationReportsRequestObject = activationReportsRequestObject.copyWith(
      page: Constants.oneNum.toInt(),
    );
    // ignore: void_checks
    return (await _activationsReportsUsecase
            .execute(activationReportsRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("refreshReportsActivations failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activationsReports0) async {
        // right -> success (data)
        activationsReports = activationsReports0;
        listOfActivations = activationsReports;
        inputReportsActivations.add(listOfActivations);
        inputState.add(ContentState());
      },
    );
  }

  @override
  Future getFilteredActivationsList({int? profileId}) async {
    inputReportsActivations.add(ActivationsReports([], 0));
    activationReportsRequestObject = activationReportsRequestObject.copyWith(
      page: Constants.oneNum.toInt(),
      profileId: profileId ?? Constants.minusOne,
    );
    // ignore: void_checks
    return (await _activationsReportsUsecase
            .execute(activationReportsRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getFilteredActivationsList failure = ${failure.code}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activationsReports0) async {
        // right -> success (data)
        activationsReports = activationsReports0;
        inputReportsActivations.add(activationsReports);
        debugPrint("users@ page = $page");
        inputState.add(ContentState());
      },
    );
  }
}
