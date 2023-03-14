import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sasuki/app/app_prefs.dart';
import 'package:sasuki/app/constants.dart';
import 'package:sasuki/app/dependency_injections/init_app_module.dart';
import 'package:sasuki/app/functions.dart';
import 'package:sasuki/app/widgets/statusbar_height.dart';
import 'package:sasuki/domain/usecase/login_usecase/login_usecase_input.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:sasuki/presentation/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/presentation/resources/other_managers/assets_manager.dart';
import 'package:sasuki/presentation/resources/other_managers/color_manager.dart';
import 'package:sasuki/presentation/resources/other_managers/opacity_manager.dart';
import 'package:sasuki/presentation/resources/other_managers/strings_manager.dart';
import 'package:sasuki/presentation/resources/other_managers/styles_manager.dart';
import 'package:sasuki/presentation/resources/routes_manager/nav.dart';
import 'package:sasuki/presentation/resources/routes_manager/routes.dart';
import 'package:sasuki/presentation/resources/values_manager/app_margin.dart';
import 'package:sasuki/presentation/resources/values_manager/app_padding.dart';
import 'package:sasuki/presentation/resources/values_manager/app_size.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPrefs = instance<AppPreferences>();
  final _userNameController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _enteredCaptchaController = TextEditingController();
  final _entered2AuthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? rememberMe;
  LoginUseCaseInput? savedUsernamePassword;
  _bind() {
    _viewModel.start();
    _getRememberMe();
    _userNameController.addListener(
      () {
        _viewModel.setUsername(_userNameController.text);
      },
    );
    _userPasswordController.addListener(
      () {
        _viewModel.setPassword(_userPasswordController.text);
      },
    );
    _enteredCaptchaController.addListener(
      () {
        _viewModel.setCaptcha(_enteredCaptchaController.text);
      },
    );
    _entered2AuthController.addListener(
      () {
        _viewModel.set2Auth(_entered2AuthController.text);
      },
    );
    _viewModel.isUserLoggedinSuccessfullyStreamController.stream.listen(
      (event) {
        if (event) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              _appPrefs.setIsUserLoggedIn();
              Nav.replaceTo(context, Routes.dashboardRoute);
            },
          );
        }
      },
    );
  }

  _getLoginObject() async {
    final loginUseCaseInput = await _appPrefs.getLoginObject();
    if (loginUseCaseInput != null) {
      savedUsernamePassword = LoginUseCaseInput.fromJson(
        jsonDecode(loginUseCaseInput),
      );
      _userNameController.text = _viewModel.savedUsernamePassword!.username;
      _userPasswordController.text = _viewModel.savedUsernamePassword!.password;
    }
  }

  _getRememberMe() async {
    rememberMe = await _appPrefs.getRememberMe();
    if (rememberMe != null || rememberMe == true) {
      _getLoginObject();
    } else {
      rememberMe = false;
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, AsyncSnapshot<FlowState> snapshot) {
            return snapshot.data?.getScreenWidget(
                  context,
                  _getContentWidget(),
                  () {
                    _viewModel.login();
                  },
                ) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusBarHeight(context: context),
            const SizedBox(height: AppSize.s36),
            _getSasukiLogo(),
            const SizedBox(height: AppSize.s18),
            Center(child: _getSelectedServer()),
            const SizedBox(height: AppSize.s18),
            StreamBuilder<bool>(
                stream: _viewModel.outputIs2AuthRequiredValid,
                builder: (context, snapshot) {
                  return (snapshot.data ?? false) ? _show2Auth() : _showLogin();
                }),
            const SizedBox(height: AppSize.s18),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide.none,
                  textStyle: getRegularStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s20,
                  ),
                ),
                onPressed: () =>
                    Nav.replaceTo(context, Routes.chooseServerRoute),
                child: const Text(AppStrings.servChangeServer),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                child: SvgPicture.asset(ImageAssets.backgroundSvg),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _showLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _getLoginToServerTitle(),
        const SizedBox(height: AppSize.s25),
        _getSingleTextField(
          controller: _userNameController,
          // controller: rememberMe == true ? null : _userNameController,
          stream: _viewModel.outputIsUsernameValid,
          labelText: AppStrings.servUsername,
          errorText: AppStrings.servInvalidUsername,
          autofocus: Constants.trueVal,
        ),
        const SizedBox(height: AppSize.s18),
        _getSingleTextField(
          // controller: rememberMe == true ? null : _userPasswordController,
          controller: _userPasswordController,
          stream: _viewModel.outputIsPasswordValid,
          labelText: AppStrings.servPassword,
          errorText: AppStrings.servInvalidPassword,
          showPassword: Constants.trueVal,
          autofocus: Constants.falseVal,
        ),
        const SizedBox(height: AppSize.s18),
        _rememberMeCheckBox(),
        const SizedBox(height: AppSize.s20),
        _getLoginButton(
          AppStrings.servLogin,
          () async {
            if (_viewModel.requiredCaptcha == 1) {
              await _viewModel.getCaptcha();
              showDialogWidget();
            } else {
              _viewModel.login();
            }
          },
          _viewModel.outputAreAllInputsValid,
        ),
        Container(),
      ],
    );
  }

  Widget _rememberMeCheckBox() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: rememberMe ?? Constants.falseVal,
            onChanged: (value) {
              setState(() {
                rememberMe = value;
              });
              _appPrefs.setLoginObject(
                LoginUseCaseInput(
                  _userNameController.text,
                  _userPasswordController.text,
                  Constants.en,
                  Constants.empty,
                  Constants.empty,
                  Constants.empty,
                ),
              );
              _viewModel.setUnsetRememberMe(rememberMe ?? Constants.falseVal);
            },
            fillColor: MaterialStateProperty.all(ColorManager.filledCheckbox),
            activeColor: Colors.white,
            checkColor: Colors.black,
          ),
          Text(
            AppStrings.servRememberMe,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Column _show2Auth() {
    return Column(
      children: [
        Center(
          child: Text(
            AppStrings.serv2Auth,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSize.s12),
        Center(
          child: Text(
            AppStrings.serv2AuthDescription,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppSize.s25),
        StreamBuilder<bool>(
          stream: _viewModel.outputIs2AuthEnteredValid,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s32),
              child: PinCodeTextField(
                appContext: context,
                length: Constants.inputLength,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: AppSize.s46,
                  fieldWidth: AppSize.s40,
                  selectedColor: ColorManager.white,
                  activeColor: ColorManager.white,
                  inactiveColor: ColorManager.white,
                ),
                autoFocus: Constants.trueVal,
                autoDismissKeyboard: Constants.trueVal,
                textStyle: Theme.of(context).textTheme.titleLarge,
                cursorColor: ColorManager.white,
                controller: _entered2AuthController,
                keyboardType: TextInputType.number,
                pastedTextStyle: TextStyle(
                  color: ColorManager.success,
                  fontWeight: FontWeight.bold,
                ),
                onCompleted: (v) {},
                onChanged: (v) {},
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return false;
                },
              ),
            );
          },
        ),
        const SizedBox(height: AppSize.s18),
        _getLoginButton(
          AppStrings.servContinue,
          _viewModel.login,
          _viewModel.outputIs2AuthEnteredValid,
        ),
      ],
    );
  }

  StreamBuilder<bool> _getLoginButton(
    String buttonText,
    void Function()? onPressed,
    Stream<bool>? stream,
  ) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m36),
          child: Center(
            child: ElevatedButton(
              onPressed: (snapshot.data ?? false) ? onPressed : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(buttonText),
                  Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showDialogWidget() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: AppSize.radius10),
          elevation: AppSize.s1_5,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.rectangle,
              borderRadius: AppSize.radius10,
              boxShadow: const [BoxShadow(color: Colors.black26)],
            ),
            child: _getCaptchaDialogContent(),
          ),
        );
      },
    );
  }

  Widget _getCaptchaDialogContent() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p36,
        left: AppPadding.p16,
        right: AppPadding.p16,
        bottom: AppPadding.p16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.primary.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Image.memory(
              dataFromBase64String(_viewModel.captchaText),
              width: 200,
              frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  child: child,
                );
              },
            ),
          ),
          const SizedBox(height: AppSize.s16),
          _getSingleTextField(
            stream: _viewModel.outputIsCaptchaValid,
            controller: _enteredCaptchaController,
            hintText: AppStrings.captchaInputHint,
            style: getSemiBoldStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s16,
            ),
            hintStyle: getRegularStyle(
              color: ColorManager.primary.withOpacity(AppOpacity.op50),
              fontSize: FontSize.s16,
            ),
            border: _normalWhiteBorder(),
            border2: _errorBorder(),
            errorText: AppStrings.captchaError,
            autofocus: Constants.trueVal,
          ),
          const SizedBox(height: AppSize.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<bool>(
                  stream: _viewModel.outputIsCaptchaValid,
                  builder: (context, snapshot) {
                    return (snapshot.data ?? false)
                        ? TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: ColorManager.transparent,
                              foregroundColor: ColorManager.primary,
                              textStyle: getRegularStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s20,
                              ),
                            ),
                            onPressed: () {
                              Nav.popRoute(context);
                              _viewModel.login();
                              // _enteredCaptchaController.clear();
                            },
                            child: const Text(AppStrings.okButton),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                              disabledForegroundColor: ColorManager.grey,
                              disabledBackgroundColor: ColorManager.transparent,
                              textStyle: getRegularStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s20,
                              ),
                            ),
                            onPressed: null,
                            child: const Text(AppStrings.okButton),
                          );
                  }),
            ],
          ),
          const SizedBox(height: AppSize.s16),
        ],
      ),
    );
  }

  Container _getLoginToServerTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m36),
      child: Text(
        AppStrings.servLoginToServer,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Container _getSelectedServer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m36),
      child: Text(
        "${_viewModel.selectedServer?.name}",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  Center _getSasukiLogo() {
    return Center(
      child: Image.asset(
        ImageAssets.sasukiLogo,
        height: AppSize.s92,
        width: AppSize.s179,
      ),
    );
  }

  bool showHidePassword = Constants.trueVal;

  Padding _getSingleTextField({
    Stream<bool>? stream,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    String? errorText,
    InputBorder? border,
    InputBorder? border2,
    TextStyle? style,
    TextStyle? hintStyle,
    bool? autofocus,
    bool showPassword = Constants.falseVal,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p36,
        right: AppPadding.p36,
      ),
      child: StreamBuilder<bool>(
          stream: stream,
          builder: (context, snapshot) {
            return Stack(
              children: [
                TextFormField(
                  onChanged: onChanged,
                  controller: controller,
                  autofocus: autofocus ?? false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.titleLarge,
                  obscureText:
                      showPassword ? showHidePassword : Constants.falseVal,
                  decoration: InputDecoration(
                    labelText: labelText,
                    labelStyle: getMediumStyle(
                      color: ColorManager.white.withOpacity(AppOpacity.op40),
                      fontSize: FontSize.s16,
                    ),
                    hintText: hintText,
                    hintStyle: hintStyle,
                    enabledBorder: border,
                    focusedBorder: border,
                    errorBorder: border2,
                    focusedErrorBorder: border2,
                    border: border,
                    errorText: (snapshot.data ?? true) ? null : errorText,
                  ),
                ),
                showPassword
                    ? Container(
                        margin: const EdgeInsets.only(right: AppMargin.m8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            IconButton(
                              icon: Icon(
                                showHidePassword
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: ColorManager.white
                                    .withOpacity(AppOpacity.op40),
                                size: AppSize.s20,
                              ),
                              onPressed: () {
                                setState(() {
                                  showHidePassword = !showHidePassword;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            );
          }),
    );
  }

  UnderlineInputBorder _normalWhiteBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorManager.primary,
        width: AppSize.s1_5,
      ),
    );
  }

  UnderlineInputBorder _errorBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorManager.orange,
        width: AppSize.s1_5,
      ),
    );
  }
}
