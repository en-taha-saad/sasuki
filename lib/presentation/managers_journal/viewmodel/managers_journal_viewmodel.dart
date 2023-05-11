import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/manager_journal/manager_journal.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/manager_journal_usecase/manager_journal_usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/managers_journal/viewmodel/managers_journal_viewmodel_inputs.dart';
import 'package:sasuki/presentation/managers_journal/viewmodel/managers_journal_viewmodel_outputs.dart';

class ManagersJournalViewModel extends BaseViewModel
    with ManagersJournalViewModelInputs, ManagersJournalViewModelOutputs {
  final ManagerJournalUsecase _managerJournalUsecase;
  final CaptchaUseCase? _captchaUseCase;

  ManagersJournalViewModel(
    this._managerJournalUsecase,
    this._captchaUseCase,
  );

  ManagerJournalRequestObject managerJournalRequestObject =
      ManagerJournalRequestObject(
    Constants.oneNum.toInt(),
    Constants.twintyNum,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    [],
  );
  ManagerJournal? managerJournal;
  int page = Constants.oneNum.toInt();
  Captcha? dataCaptcha;
  ManagerJournal? listOfJournal;

  @override
  void start() async {
    _getCaptchaResponse();

    await getManagersJournal();
  }

  @override
  void dispose() {
    _managersJournalController.close();
    _captchaController.close();
    super.dispose();
  }
  @override
  Future getManagersJournal() async {
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.activationsReports,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    return (await _managerJournalUsecase.execute(managerJournalRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("failure getManagersJournal failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerJournal0) async {
        debugPrint("getManagersJournal failure = ${managerJournal0.total}");
        // right -> success (data)
        managerJournal = managerJournal0;
        inputState.add(ContentState());
        inputManagersJournal.add(managerJournal);
        getManagersJournalForPull();
      },
    );
  }

  @override
  Future getNextManagersJournal() async {
    managerJournalRequestObject =
        managerJournalRequestObject.copyWith(page: page++);
    // ignore: void_checks
    return (await _managerJournalUsecase.execute(managerJournalRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getNextManagersJournal failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerJournal0) async {
        // right -> success (data)
        managerJournal = managerJournal0;
        listOfJournal?.data?.addAll((managerJournal?.data)!);
        inputManagersJournal.add(listOfJournal);
        inputState.add(ContentState());
        // make function to get next page
        // getReportsActivationsForPull();
      },
    );
  }

  @override
  getManagersJournalStreamingly() async {
    return (await _managerJournalUsecase.execute(managerJournalRequestObject))
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
            "getManagersJournalStreamingly failure = ${failure.message}");
      },
      (managerJournal0) async {
        // right -> success (data)
        managerJournal = managerJournal0;
        inputManagersJournal.add(managerJournal);
        // inputState.add(ContentState());
      },
    );
  }

  @override
  Future getManagersJournalForPull() async {
    managerJournalRequestObject = managerJournalRequestObject.copyWith(
      page: Constants.oneNum.toInt(),
    );
    // ignore: void_checks
    return (await _managerJournalUsecase.execute(managerJournalRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getManagersJournalForPull failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerJournal0) async {
        // right -> success (data)
        managerJournal = managerJournal0;
        listOfJournal = managerJournal;
        inputManagersJournal.add(listOfJournal);
        inputState.add(ContentState());
      },
    );
  }

  ///
  final StreamController _managersJournalController =
      StreamController<ManagerJournal>.broadcast();

  @override
  Sink get inputManagersJournal => _managersJournalController.sink;

  @override
  Stream<ManagerJournal> get outputManagersJournal =>
      _managersJournalController.stream.map(
        (managersJournal) => managersJournal,
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
  refreshManagersJournal() async {
    managerJournalRequestObject = managerJournalRequestObject.copyWith(
      page: Constants.oneNum.toInt(),
    );
    // ignore: void_checks
    return (await _managerJournalUsecase.execute(managerJournalRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("refreshManagersJournal failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managerJournal0) async {
        // right -> success (data)
        managerJournal = managerJournal0;
        listOfJournal = managerJournal;
        inputManagersJournal.add(listOfJournal);
        inputState.add(ContentState());
      },
    );
  }
}
