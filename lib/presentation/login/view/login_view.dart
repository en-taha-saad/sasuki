import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_data_from_base64string.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/footer.dart';
import 'package:sasuki/app/shared_widgets/small_logo.dart';
import 'package:sasuki/domain/usecase/login_usecase/login_usecase_input.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/login/viewmodel/login_viewmodel.dart';

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
  bool showHidePassword = Constants.trueBool;
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
              // TODO : Navigate to dashboard
              // Nav.replaceTo(context, Routes.dashboardRoute);
            },
          );
        }
      },
    );
  }

  _getLoginObject() async {
    final loginUseCaseInput = await _appPrefs.getLoginObject();
    if (loginUseCaseInput != Constants.nullValue) {
      savedUsernamePassword = LoginUseCaseInput.fromJson(
        jsonDecode(loginUseCaseInput!),
      );
      _userNameController.text = _viewModel.savedUsernamePassword!.username;
      _userPasswordController.text = _viewModel.savedUsernamePassword!.password;
    }
  }

  _getRememberMe() async {
    rememberMe = await _appPrefs.getRememberMe();
    if (rememberMe != Constants.nullValue || rememberMe == Constants.trueBool) {
      _getLoginObject();
    } else {
      rememberMe = Constants.falseBool;
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
      onWillPop: () async => Constants.falseBool,
      child: StreamBuilder<FlowState>(
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
          }),
    );
  }

  Widget _getContentWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        getScreenFooter(),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSize.s100),
              getScreenSmallLogo(),
              const SizedBox(height: AppSize.s25),
              getScreenContent(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget getScreenContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSize.s25),
      child: Column(
        children: [
          Text(
            "${_viewModel.selectedServer?.name}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSize.s50),
          StreamBuilder<bool>(
            stream: _viewModel.outputIs2AuthRequiredValid,
            builder: (context, snapshot) {
              return (snapshot.data ?? false) ? _show2Auth() : _showLogin();
            },
          ),
          const SizedBox(height: AppSize.s10),
          InkWell(
            onTap: () => Nav.replaceTo(context, Routes.chooseServerRoute),
            child: Text(
              AppStrings.servChangeServer,
              style: StylesManager.getSemiBoldStyle(
                fontSize: FontSize.sButton,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(IconsAssets.login),
            const SizedBox(width: AppSize.s10),
            Text(
              AppStrings.servLoginToServer,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s25),
        _getDataContentWidget(),
        const SizedBox(height: AppSize.s50),
        StreamBuilder<bool>(
          stream: _viewModel.outputAreAllInputsValid,
          builder: (context, snapshot) {
            return ElevatedButtonWidget(
              name: AppStrings.servLogin,
              onPressed: (snapshot.data ?? Constants.falseBool)
                  ? _login
                  : Constants.nullValue,
            );
          },
        ),
      ],
    );
  }

  Widget _getDataContentWidget() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getSingleTextField(
            stream: _viewModel.outputIsUsernameValid,
            controller: _userNameController,
            // controller: rememberMe == true ? null : _userNameController,
            inputLabel: AppStrings.servUsername,
            inputHint: AppStrings.servUsernameHint,
            errorText: AppStrings.servInvalidUsername,
            autofocus: Constants.trueBool,
          ),
          const SizedBox(height: AppSize.s25),
          _getSingleTextField(
            stream: _viewModel.outputIsPasswordValid,
            controller: _userPasswordController,
            // controller: rememberMe == true ? null : _userPasswordController,
            inputLabel: AppStrings.servPassword,
            inputHint: AppStrings.servPasswordHint,
            errorText: AppStrings.servInvalidPassword,
            autofocus: Constants.falseBool,
            obscureText: Constants.trueBool,
          ),
          const SizedBox(height: AppSize.s25),
          _rememberMeCheckBox(),
        ],
      ),
    );
  }

  Widget _getSingleTextField({
    Stream<bool>? stream,
    TextEditingController? controller,
    String? inputLabel,
    String? inputHint,
    String? errorText,
    bool? autofocus,
    bool obscureText = Constants.falseBool,
  }) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            inputLabel != Constants.nullValue
                ? Text(
                    inputLabel!,
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                : Container(),
            inputLabel != Constants.nullValue
                ? const SizedBox(height: AppSize.s10)
                : Container(),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: inputHint,
                errorText: (snapshot.data ?? Constants.trueBool)
                    ? Constants.nullValue
                    : errorText,
                suffix: obscureText
                    ? IconButton(
                        icon: Icon(
                          showHidePassword
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: ColorManager.whiteNeutral,
                        ),
                        onPressed: () => setState(
                            () => showHidePassword = !showHidePassword),
                      )
                    : null,
              ),
              autofocus: autofocus!,
            ),
          ],
        );
      },
    );
  }

  Widget _rememberMeCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: rememberMe ?? Constants.falseBool,
          onChanged: (value) {
            setState(() => rememberMe = value);
            _appPrefs.setLoginObject(
              LoginUseCaseInput(
                _userNameController.text,
                _userPasswordController.text,
                Constants.en,
                Constants.emptyStr,
                Constants.emptyStr,
                Constants.emptyStr,
              ),
            );
            _viewModel.setUnsetRememberMe(rememberMe ?? Constants.falseBool);
          },
          fillColor: MaterialStateProperty.all(ColorManager.semiBlackNeutral),
          activeColor: Colors.white,
          checkColor: ColorManager.backgroundCenter,
        ),
        const SizedBox(width: AppSize.s15),
        Text(
          AppStrings.servRememberMe,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  _login() async {
    if (_viewModel.requiredCaptcha == AppSize.s1) {
      await _viewModel.getCaptcha();
      showDialogWidget();
    } else {
      _viewModel.login();
    }
  }

  showDialogWidget() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: RadiusSizes.radius12),
          elevation: AppSize.s1_5,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.whiteNeutral,
              shape: BoxShape.rectangle,
              borderRadius: RadiusSizes.radius12,
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
            width: AppSize.s200,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.primaryshade1.withOpacity(AppSize.s0_5),
                width: AppSize.s1,
              ),
            ),
            child: Image.memory(
              dataFromBase64String(_viewModel.captchaText),
              width: AppSize.s200,
              frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? AppSize.s0 : AppSize.s1,
                  duration: Duration(milliseconds: AppSize.s500.toInt()),
                  child: child,
                );
              },
            ),
          ),
          const SizedBox(height: AppSize.s16),
          _getSingleTextField(
            stream: _viewModel.outputIsCaptchaValid,
            controller: _enteredCaptchaController,
            inputHint: AppStrings.captchaInputHint,
            errorText: AppStrings.captchaError,
            autofocus: Constants.trueBool,
          ),
          const SizedBox(height: AppSize.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<bool>(
                stream: _viewModel.outputIsCaptchaValid,
                builder: (context, snapshot) {
                  return TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: ColorManager.backgroundCenter,
                    ),
                    onPressed: (snapshot.data ?? Constants.falseBool)
                        ? () {
                            Nav.popRoute(context);
                            _viewModel.login();
                            // _enteredCaptchaController.clear();
                          }
                        : Constants.nullValue,
                    child: const Text(AppStrings.okButton),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: AppSize.s16),
        ],
      ),
    );
  }

  Column _show2Auth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppStrings.servLoginToServer,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          AppStrings.serv2AuthDescription,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSize.s50),
        StreamBuilder<bool>(
          stream: _viewModel.outputIs2AuthEnteredValid,
          builder: (context, snapshot) {
            return PinCodeTextField(
              appContext: context,
              length: AppSize.s6.toInt(),
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: AppSize.s46,
                fieldWidth: AppSize.s40,
                selectedColor: ColorManager.whiteNeutral,
                activeColor: ColorManager.whiteNeutral,
                inactiveColor: ColorManager.whiteNeutral,
              ),
              autoFocus: Constants.trueBool,
              autoDismissKeyboard: Constants.trueBool,
              textStyle: Theme.of(context).textTheme.titleLarge,
              cursorColor: ColorManager.whiteNeutral,
              controller: _entered2AuthController,
              keyboardType: TextInputType.number,
              // TODO : check if this is needed
              // pastedTextStyle: TextStyle(
              //   color: ColorManager.success,
              //   fontWeight: FontWeight.bold,
              // ),
              onCompleted: (v) {},
              onChanged: (v) {},
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return Constants.falseBool;
              },
            );
          },
        ),
        const SizedBox(height: AppSize.s75),
        StreamBuilder<bool>(
          stream: _viewModel.outputIs2AuthEnteredValid,
          builder: (context, snapshot) {
            return ElevatedButtonWidget(
              name: AppStrings.servAuthenticate,
              onPressed: (snapshot.data ?? Constants.falseBool)
                  ? _login
                  : Constants.nullValue,
            );
          },
        ),
        const SizedBox(height: AppSize.s18),
      ],
    );
  }
}