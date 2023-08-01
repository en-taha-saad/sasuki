import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/dashboarddata_usecase.dart';
import 'package:sasuki/domain/usecase/servers_usecase/selected_server_usecase.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel_inputs.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel_outputs.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';

class DashboardViewModel extends BaseViewModel
    with DashboardViewModelInputs, DashboardViewModelOutputs {
  final AuthUseCase _authUseCase;
  final DashboardUseCase _dashboardDataUseCase;
  final CaptchaUseCase? _captchaUseCase;
  final SelectedServerUsecase? _selectedServerUsecase;
  Auth? auth;
  Captcha? dataCaptcha;
  Dashboard? dashboardData;
  bool? gotInforms = false;
  Server? selectedServer;
  String? error;

  DashboardViewModel(
    this._authUseCase,
    this._dashboardDataUseCase,
    this._captchaUseCase,
    this._selectedServerUsecase,
  );

  List<CardElement> listOfUserStatistics(Dashboard? dashboard) => [
        CardElement(
          AppStrings.dashboardUsers,
          AppStrings.dashboardTotalnumberofusers,
          "${dashboard?.data?.usersCount ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardOnlineUsers,
          AppStrings.dashboardNumberofonlineusers,
          "${dashboard?.data?.usersOnlineCount ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardActiveUsers,
          AppStrings.dashboardNumberofactiveusers,
          "${dashboard?.data?.activeUsersCount ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardExpiredUsers,
          AppStrings.dashboardNumberofexpiredusers,
          "${dashboard?.data?.expiredUsersCount ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardAboutToExpire,
          AppStrings.dashboardUsersactivebutgoingtoexpiretoday,
          "${dashboard?.data?.expiringSoonCount ?? Constants.dash}",
        ),
      ];

  List<CardElement> listOfSalesAndFinance(Dashboard? dashboard) => [
        CardElement(
          AppStrings.dashboardNewRegistrations,
          AppStrings.dashboardUsersaddedthismonth,
          "${dashboard?.data?.registredToday ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardActivations,
          AppStrings.dashboardUsersactivatedthismonth,
          "${dashboard?.data?.activationsToday ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardSales,
          AppStrings.dashboardTotalsalesforthismonth,
          "${dashboard?.data?.salesToday ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardProfits,
          AppStrings.dashboardmonthlyprofits,
          "${dashboard?.data?.profitsToday ?? Constants.dash}",
        ),
        CardElement(
          AppStrings.dashboardRewardPoints,
          AppStrings.dashboardrewardpointsbalance,
          "${dashboard?.data?.rewardPointsBalance ?? Constants.dash}",
        ),
      ];

  final StreamController _errorController =
      StreamController<String?>.broadcast();
  Sink get inputError => _errorController.sink;
  Stream<String?> get outputError => _errorController.stream.map(
        (error) => error,
      );

  ///
  final StreamController _dashboardController =
      StreamController<Dashboard>.broadcast();
  final StreamController _authController = StreamController<Auth>.broadcast();
  final StreamController _captchaController =
      StreamController<Captcha>.broadcast();

  @override
  void start() {
    _getSelectedServer();
    getDashboardData();
  }

  @override
  void dispose() {
    // _dashboardController.close();
    // _authController.close();
    // _captchaController.close();
    // _errorController.close();

  }

  @override
  getDashboardData() async {
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.dashboard,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    return (await _dashboardDataUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getDashboardData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        inputError.add(failure.message);
      },
      (dashboard0) async {
        // right -> success (data)
        dashboardData = dashboard0;
        debugPrint("dashboard = ${dashboard0.status}");
        _getCaptchaResponse();
        inputError.add(null);
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
        getAuth();
      },
    );
  }

  _getSelectedServer() async {
    // ignore: void_checks
    (await _selectedServerUsecase?.execute(Void))?.fold(
      (failure) {
        // left -> failure
        debugPrint("failure = ${failure.message}");
      },
      (selectedServer0) {
        // right -> success (data)
        debugPrint("success selectedServer = ${selectedServer?.name}");
        selectedServer = selectedServer0;
      },
    );
  }

  @override
  getAuth() async {
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
        auth = auth0;
        debugPrint("auth = ${auth?.permissions}");
        inputDashboardData.add(dashboardData);
        getDataStreamingly();
        inputState.add(ContentState());
      },
    );
  }

  @override
  Sink get inputDashboardData => _dashboardController.sink;

  @override
  Sink get inputAuthData => _authController.sink;

  @override
  Sink get inputDataCaptcha => _captchaController.sink;

  @override
  Stream<Dashboard> get outputDashboardData => _dashboardController.stream.map(
        (dashboard) => dashboard,
      );

  @override
  Stream<Auth> get outputAuthData => _authController.stream.map(
        (auth) => auth,
      );

  @override
  Stream<Captcha> get outputDataCaptcha => _captchaController.stream.map(
        (captcha) => captcha,
      );

  @override
  getDataStreamingly() async {
    // ignore: void_checks
    return (await _dashboardDataUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
        inputError.add(failure.message);

        debugPrint("getDataStreamingly failure = ${failure.message}");
      },
      (dashboard0) async {
        // right -> success (data)
        debugPrint("dashboard = ${dashboard0.status}");
        dashboardData = dashboard0;
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
            inputError.add(failure.message);
          },
          (auth0) async {
            // right -> success (data)
            auth = auth0;
            debugPrint("auth = ${auth?.status}");
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
                inputError.add(failure.message);
              },
              (Captcha dataCaptcha0) {
                // right -> success (data)
                dataCaptcha = dataCaptcha0;
                inputAuthData.add(auth);
                inputDashboardData.add(dashboardData);
                inputDataCaptcha.add(dataCaptcha);
                gotInforms = true;
                inputError.add(null);
              },
            );
          },
        );
      },
    );
  }
}
