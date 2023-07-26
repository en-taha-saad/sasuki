import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/data/network/error_handler/api_internal_status.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/responsecaptcha_usecase.dart';
import 'package:sasuki/domain/usecase/login_usecase/login_usecase.dart';
import 'package:sasuki/domain/usecase/login_usecase/login_usecase_input.dart';
import 'package:sasuki/domain/usecase/servers_usecase/selected_server_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/login/viewmodel/login_viewmodel_inputs.dart';
import 'package:sasuki/presentation/login/viewmodel/login_viewmodel_outputs.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:uuid/uuid.dart';

String? token;

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final LoginUseCase _loginUseCase;
  final CaptchaUseCase _captchaUseCase;
  final ResponseCaptchaUseCase _responseCaptchaUseCase;
  final SelectedServerUsecase _selectedServerUsecase;
  LoginViewModel(
    this._loginUseCase,
    this._captchaUseCase,
    this._responseCaptchaUseCase,
    this._selectedServerUsecase,
  );
  var loginObject = LoginObject(
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.en,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
  );
  final AppPreferences _appPrefs = instance<AppPreferences>();
  Server? selectedServer;
  bool? rememberMe;
  LoginUseCaseInput? savedUsernamePassword;

  _getSelectedServer() async {
    // ignore: void_checks
    return (await _selectedServerUsecase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("_getSelectedServer failure = ${failure.message}");
      },
      (selectedServer0) {
        // right -> success (data)
        selectedServer = selectedServer0;
        debugPrint("_getSelectedServer = ${selectedServer0?.name}");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.close();
    _passwordController.close();
    _captchaController.close();
    _isCaptchaEnteredStreamController.close();
    _twoAuthController.close();
    _is2AuthRequiredStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedinSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view, please show content state
    _getSelectedServer();
    isRequiredCaptcha();
    _getRememberMe();

    inputState.add(ContentState());
  }

  setUnsetRememberMe(bool checkRememberMe) async {
    return await _appPrefs.setUnsetRememberMe(checkRememberMe);
  }

//
  setLoginObject(LoginUseCaseInput loginUseCaseInput) async {
    return await _appPrefs.setLoginObject(loginUseCaseInput);
  }

  _getLoginObject() async {
    final loginUseCaseInput = await _appPrefs.getLoginObject();
    if (loginUseCaseInput != null) {
      savedUsernamePassword = LoginUseCaseInput.fromJson(
        jsonDecode(loginUseCaseInput),
      );
    }
  }

  _getRememberMe() async {
    inputState.add(ContentState());
    rememberMe = await _appPrefs.getRememberMe();
    if (rememberMe != null || rememberMe == true) {
      _getLoginObject();
    } else {
      rememberMe = false;
    }
  }

  ///
  final StreamController _userNameController =
      StreamController<String>.broadcast();
  @override
  Sink get inputUsername => _userNameController.sink;
  bool _isUsernameValid(String username) => username.isNotEmpty;
  @override
  Stream<bool> get outputIsUsernameValid {
    return _userNameController.stream.map(
      (userName) => _isUsernameValid(userName),
    );
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  ///
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  @override
  Sink get inputPassword => _passwordController.sink;
  bool _isPasswordValid(String password) => password.isNotEmpty;
  @override
  Stream<bool> get outputIsPasswordValid {
    return _passwordController.stream.map(
      (password) => _isPasswordValid(password),
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  ///
  int requiredCaptcha = Constants.zeroNum.toInt();
  String captchaText = Constants.emptyStr;
  final StreamController _captchaController =
      StreamController<String>.broadcast();
  @override
  Sink get inputCaptcha => _captchaController.sink;
  bool _isCaptchaValid(String captcha) => captcha.isNotEmpty;
  @override
  Stream<bool> get outputIsCaptchaValid {
    return _captchaController.stream.map(
      (captcha) => _isCaptchaValid(captcha),
    );
  }

  ///
  final StreamController _isCaptchaEnteredStreamController =
      StreamController<bool>.broadcast();
  @override
  Sink get inputIsCaptchaEnteredValid => _isCaptchaEnteredStreamController.sink;
  @override
  Stream<bool> get outputIsCaptchaEnteredValid {
    return _isCaptchaEnteredStreamController.stream.map(
      (captcha) => _isCaptchaValid(captcha),
    );
  }

  @override
  setCaptcha(String captcha) {
    inputCaptcha.add(captcha);
    loginObject = loginObject.copyWith(captchaText: captcha);
    inputIsCaptchaEnteredValid.add(Constants.falseBool);
  }

  @override
  isRequiredCaptcha() async {
    // ignore: void_checks
    (await _captchaUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("failure = ${failure.message}");
      },
      (data) {
        // right -> success (data)
        if (data.data?.requiresCaptcha == 1) requiredCaptcha = 1;
      },
    );
  }

  @override
  getCaptcha() async {
    String sessionId = const Uuid().v1();
    loginObject = loginObject.copyWith(sessionId: sessionId);

    // ignore: void_checks
    (await _responseCaptchaUseCase.execute(loginObject.sessionId)).fold(
      (failure) {
        // left -> failure
        debugPrint("failure = ${failure.message}");
      },
      (data) {
        // right -> success (data)
        debugPrint("status = ${data.status}");
        debugPrint("getCaptcha = ${data.data}");
        captchaText = data.data;
      },
    );
  }

  _resetCaptchaTextInput() {
    inputCaptcha.add("");
    inputIsCaptchaEnteredValid.add(Constants.falseBool);
  }

  ///
  final StreamController _twoAuthController =
      StreamController<String>.broadcast();
  @override
  Sink get input2Auth => _twoAuthController.sink;
  bool _is2AuthValid(String twoAuth) => twoAuth.length == 6;
  @override
  Stream<bool> get outputIs2AuthEnteredValid {
    return _twoAuthController.stream.map(
      (twoAuth) => _is2AuthValid(twoAuth),
    );
  }

  @override
  set2Auth(String twoAuth) {
    input2Auth.add(twoAuth);
    loginObject = loginObject.copyWith(otp: twoAuth);
  }

  ///
  final StreamController _is2AuthRequiredStreamController =
      StreamController<bool>.broadcast();
  @override
  Sink get inputIs2AuthRequiredValid => _is2AuthRequiredStreamController.sink;
  @override
  Stream<bool> get outputIs2AuthRequiredValid {
    return _is2AuthRequiredStreamController.stream.map((twoAuth) => twoAuth);
  }

  ///
  final StreamController _areAllInputsValidStreamController =
      StreamController<bool>.broadcast();
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  bool _areAllInputsValid() =>
      _isUsernameValid(loginObject.username) &&
      _isPasswordValid(loginObject.password);
  @override
  Stream<bool> get outputAreAllInputsValid {
    return _areAllInputsValidStreamController.stream.map(
      (_) => _areAllInputsValid(),
    );
  }

  ///
  final StreamController isUserLoggedinSuccessfullyStreamController =
      StreamController<bool>.broadcast();

  @override
  login() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );
    Logger().d("loginObject otp = ${loginObject.otp}");
    (await _loginUseCase.execute(
      LoginUseCaseInput(
        loginObject.username,
        loginObject.password,
        loginObject.language,
        loginObject.otp,
        loginObject.captchaText,
        loginObject.sessionId,
      ),
    ))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("@failure = ${failure.code}");
        _resetCaptchaTextInput();
        if (failure.code == ApiInternalStatus.twoAuthStatus) {
          inputIs2AuthRequiredValid.add(Constants.trueBool);
          inputState.add(ContentState());
        } else {
          inputIs2AuthRequiredValid.add(Constants.falseBool);
          inputState.add(
            ErrorState(
              StateRendererType.popupErrorState,
              failure.message,
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            inputState.add(ContentState());
          });
        }
      },
      (data) async {
        // right -> success (data)
        inputState.add(ContentState());
        isUserLoggedinSuccessfullyStreamController.add(Constants.trueBool);
        await _appPrefs.setLoginObject(
          LoginUseCaseInput(
            loginObject.username,
            loginObject.password,
            loginObject.language,
            loginObject.otp,
            loginObject.captchaText,
            loginObject.sessionId,
          ),
        );
        _appPrefs.removeIsUserLoggedInStatus();
        _appPrefs.removeToken();
        await _appPrefs.setToken(data.token);
        token = data.token;
      },
    );
  }
}
