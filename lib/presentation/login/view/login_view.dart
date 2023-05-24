import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/change_status_bar_color.dart';
import 'package:sasuki/app/shared_funs/get_data_from_base64string.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/footer.dart';
import 'package:sasuki/app/shared_widgets/password_input.dart';
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
  bool showPassword = Constants.falseBool;
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
    changeStatusBarColor();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    changeStatusBarColor();

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
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
                const SizedBox(height: AppSize.s100),
              ],
            ),
          ),
        ],
      ),
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
          const SizedBox(height: AppSize.s35),
          StreamBuilder<bool>(
            stream: _viewModel.outputIs2AuthRequiredValid,
            builder: (context, snapshot) {
              return (snapshot.data ?? Constants.falseBool)
                  ? _show2Auth()
                  : _showLogin();
            },
          ),
          const SizedBox(height: AppSize.s15),
          InkWell(
            onTap: () => Nav.replaceTo(context, Routes.chooseServerRoute),
            child: Text(
              AppStrings.servChangeServer,
              style: Theme.of(context).textTheme.headlineSmall,
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
            SvgPicture.asset(
              IconsAssets.login,
              theme: const SvgTheme(
                currentColor: ColorManager.greyNeutral,
              ),
              // ignore: deprecated_member_use
              color: ColorManager.greyNeutral,
            ),
            const SizedBox(width: AppSize.s10),
            Text(
              AppStrings.servLoginToServer,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: ColorManager.greyNeutral,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s25),
        _getLoginContentWidget(),
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

  Widget _getLoginContentWidget() {
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
            onTap: () {},
            onFieldSubmitted: (value) {},
          ),
          const SizedBox(height: AppSize.s25),
          PasswordTextInput(
            stream: _viewModel.outputIsPasswordValid,
            controller: _userPasswordController,
            // controller: rememberMe == true ? null : _userPasswordController,
            inputLabel: AppStrings.servPassword,
            inputHint: AppStrings.servPasswordHint,
            errorText: AppStrings.servInvalidPassword,
            autofocus: Constants.falseBool,
            showPassword: Constants.trueBool,
            onTap: () {},
            onFieldSubmitted: (value) {},
          ),
          const SizedBox(height: AppSize.s15),
          _rememberMeCheckBoxWidget(),
        ],
      ),
    );
  }

  Widget _getCaptchaTextField({
    Stream<bool>? stream,
    TextEditingController? controller,
    String? inputLabel,
    String? inputHint,
    String? errorText,
    bool? autofocus,
    bool showPassword = Constants.falseBool,
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
            Stack(
              children: [
                TextFormField(
                  controller: controller,
                  cursorColor: ColorManager.blackNeutral,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorManager.blackNeutral,
                      ),
                  decoration: InputDecoration(
                    hintText: inputHint,
                    fillColor: ColorManager.greyNeutral.withOpacity(0.25),
                    errorText: (snapshot.data ?? Constants.trueBool)
                        ? Constants.nullValue
                        : errorText,
                  ),
                  obscureText:
                      showPassword ? showHidePassword : Constants.falseBool,
                  autofocus: autofocus!,
                ),
                showPassword
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: AppMargin.m12,
                          right: AppMargin.m12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            InkWell(
                              child: SvgPicture.asset(
                                showHidePassword
                                    ? IconsAssets.eyeslash
                                    : IconsAssets.eye,
                                theme: const SvgTheme(
                                  currentColor: ColorManager.whiteNeutral,
                                ),
                                // ignore: deprecated_member_use
                                color: ColorManager.whiteNeutral,
                              ),
                              onTap: () {
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
            ),
          ],
        );
      },
    );
  }

  Widget _getSingleTextField({
    Stream<bool>? stream,
    TextEditingController? controller,
    String? inputLabel,
    String? inputHint,
    String? errorText,
    bool? autofocus,
    bool showPassword = Constants.falseBool,
    Function()? onTap,
    Function(String)? onFieldSubmitted,
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
            Stack(
              children: [
                TextFormField(
                  controller: controller,
                  onTap: onTap,
                  onFieldSubmitted: onFieldSubmitted,
                  decoration: InputDecoration(
                    hintText: inputHint,
                    errorText: (snapshot.data ?? Constants.trueBool)
                        ? Constants.nullValue
                        : errorText,
                  ),
                  obscureText:
                      showPassword ? showHidePassword : Constants.falseBool,
                  autofocus: autofocus!,
                ),
                showPassword
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: AppMargin.m12,
                          right: AppMargin.m12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            InkWell(
                              child: SvgPicture.asset(
                                showHidePassword
                                    ? IconsAssets.eyeslash
                                    : IconsAssets.eye,
                                theme: const SvgTheme(
                                  currentColor: ColorManager.whiteNeutral,
                                ),
                                // ignore: deprecated_member_use
                                color: ColorManager.whiteNeutral,
                              ),
                              onTap: () {
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
            ),
          ],
        );
      },
    );
  }

  Widget _rememberMeCheckBoxWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: AppSize.s20,
          child: Checkbox(
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
          ),
        ),
        const SizedBox(width: AppSize.s15),
        Text(
          AppStrings.servRememberMe,
          style: Theme.of(context).textTheme.bodyLarge,
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
          _getCaptchaTextField(
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
                    child: Text(
                      AppStrings.userActionSubmitButton,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: (snapshot.data ?? Constants.falseBool)
                                ? ColorManager.blackNeutral
                                : ColorManager.greyNeutral,
                          ),
                    ),
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
                shape: PinCodeFieldShape.box,
                borderRadius: RadiusSizes.radius12,
                selectedColor: ColorManager.whiteNeutral,
                activeColor: ColorManager.primaryshade3,
                inactiveColor: ColorManager.backgroundCorners,
                borderWidth: AppSize.s3,
                fieldHeight: AppSize.s48,
                fieldWidth: AppSize.s48,
              ),
              autoFocus: Constants.trueBool,
              autoDismissKeyboard: Constants.trueBool,
              textStyle: Theme.of(context).textTheme.titleLarge,
              cursorColor: ColorManager.whiteNeutral,
              controller: _entered2AuthController,
              keyboardType: TextInputType.number,
              onCompleted: (v) {},
              onChanged: (v) {},
              beforeTextPaste: (text) => Constants.falseBool,
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
