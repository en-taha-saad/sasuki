import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/managers_invoices/managers_invoices.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/manager_invoices_usecase/manager_invoices_usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/managers_invoices/viewmodel/managers_invoices_viewmodel_inputs.dart';
import 'package:sasuki/presentation/managers_invoices/viewmodel/managers_invoices_viewmodel_outputs.dart';

class ManagersInvoicesViewModel extends BaseViewModel
    with ManagersInvoicesViewModelInputs, ManagersInvoicesViewModelOutputs {
  final ManagerInvoicesUsecase _managerInvoicesUsecase;
  final CaptchaUseCase? _captchaUseCase;

  ManagersInvoicesViewModel(
    this._managerInvoicesUsecase,
    this._captchaUseCase,
  );

  ManagerInvoicesRequestObject managerInvoicesRequestObject =
      ManagerInvoicesRequestObject(
    Constants.oneNum.toInt(),
    Constants.twintyNum,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    [],
  );
  ManagersInvoices? managerInvoices;
  int page = Constants.oneNum.toInt();
  Captcha? dataCaptcha;
  ManagersInvoices? listOfInvoices;

  @override
  void start() async {
    _getCaptchaResponse();

    await getManagersInvoices();
  }

  @override
  void dispose() {}
  @override
  Future getManagersInvoices() async {
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.activationsReports,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    return (await _managerInvoicesUsecase.execute(managerInvoicesRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("failure getManagersInvoices failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerInvoices0) async {
        debugPrint("getManagersInvoices failure = ${managerInvoices0.total}");
        // right -> success (data)
        managerInvoices = managerInvoices0;
        inputState.add(ContentState());
        inputManagersInvoices.add(managerInvoices);
        getManagersInvoicesForPull();
      },
    );
  }

  @override
  Future getNextManagersInvoices() async {
    managerInvoicesRequestObject =
        managerInvoicesRequestObject.copyWith(page: page++);
    // ignore: void_checks
    return (await _managerInvoicesUsecase.execute(managerInvoicesRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getNextManagersInvoices failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerInvoices0) async {
        // right -> success (data)
        managerInvoices = managerInvoices0;
        listOfInvoices?.data?.addAll((managerInvoices?.data)!);
        inputManagersInvoices.add(listOfInvoices);
        inputState.add(ContentState());
        // make function to get next page
        // getReportsActivationsForPull();
      },
    );
  }

  @override
  getManagersInvoicesStreamingly() async {
    return (await _managerInvoicesUsecase.execute(managerInvoicesRequestObject))
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
            "getManagersInvoicesStreamingly failure = ${failure.message}");
      },
      (managerInvoices0) async {
        // right -> success (data)
        managerInvoices = managerInvoices0;
        inputManagersInvoices.add(managerInvoices);
        // inputState.add(ContentState());
      },
    );
  }

  @override
  Future getManagersInvoicesForPull() async {
    managerInvoicesRequestObject = managerInvoicesRequestObject.copyWith(
      page: Constants.oneNum.toInt(),
    );
    // ignore: void_checks
    return (await _managerInvoicesUsecase.execute(managerInvoicesRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getManagersInvoicesForPull failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerInvoices0) async {
        // right -> success (data)
        managerInvoices = managerInvoices0;
        listOfInvoices = managerInvoices;
        inputManagersInvoices.add(listOfInvoices);
        inputState.add(ContentState());
      },
    );
  }

  ///
  final StreamController _managersInvoicesController =
      StreamController<ManagersInvoices>.broadcast();

  @override
  Sink get inputManagersInvoices => _managersInvoicesController.sink;

  @override
  Stream<ManagersInvoices> get outputManagersInvoices =>
      _managersInvoicesController.stream.map(
        (managersInvoices) => managersInvoices,
      );

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
  refreshManagersInvoices() async {
    managerInvoicesRequestObject = managerInvoicesRequestObject.copyWith(
      page: Constants.oneNum.toInt(),
    );
    // ignore: void_checks
    return (await _managerInvoicesUsecase.execute(managerInvoicesRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("refreshManagersInvoices failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerInvoices0) async {
        // right -> success (data)
        managerInvoices = managerInvoices0;
        listOfInvoices = managerInvoices;
        inputManagersInvoices.add(listOfInvoices);
        inputState.add(ContentState());
      },
    );
  }
}
