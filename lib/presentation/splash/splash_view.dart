import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_choose_server_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';

class SplashView0 extends StatefulWidget {
  const SplashView0({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashView0State createState() => _SplashView0State();
}

class _SplashView0State extends State<SplashView0> {
  Timer? _timer;
  final AppPreferences _appPrefs = instance<AppPreferences>();
  _startDelay() {
    _timer = Timer(const Duration(seconds: Constants.splashDelay), _goNext);
  }

  _goNext() async {
    String? token = await _appPrefs.getToken();
    _appPrefs.getIsUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn == true) {
        if (token != null) {
          bool isExpired = JwtDecoder.isExpired(token);
          debugPrint("token = $token");
          debugPrint("isExpired = $isExpired");
          if (isExpired) {
            _appPrefs.removeIsUserLoggedInStatus();
            _appPrefs.removeToken();
            initChooseServerModule();
            // navigate to login
            // TODO nav to the screen
            // Nav.replaceTo(context, Routes.loginRoute);
            return;
          }
        }
        // TODO nav to the screen
        // Nav.replaceTo(context, Routes.dashboardRoute);
        return;
      } else {
        _appPrefs.getSelectedServer().then((isChosedServer) {
          if (isChosedServer != null) {
            initChooseServerModule();
            // navigate to login
            // TODO nav to the screen
            // Nav.replaceTo(context, Routes.loginRoute);
          } else {
            // TODO nav to the screen
            // Nav.replaceTo(context, Routes.chooseServerRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorManager.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: ColorManager.primary,
        // elevation: AppSize.s0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          const Center(
              // child: Image.asset(
              //   ImageAssets.sasukiLogo,
              //   height: AppSize.s138,
              //   width: AppSize.s265,
              // ),
              ),
          // Center(child: SvgPicture.asset(ImageAssets.backgroundSvg)),
        ],
      ),
    );
  }
}

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPrefs = instance<AppPreferences>();

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: Constants.splashDelay), _goNext);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _goNext() async {
    String? token = await _appPrefs.getToken();
    _appPrefs.getIsUserLoggedIn().then(
          (isUserLoggedIn) => isUserLoggedIn == Constants.trueBool
              ? goToDashboard(token)
              : reLogin(),
        );
  }

  goToDashboard(String? token) {
    if (token != Constants.nullValue) {
      goToLoginIfExpire(JwtDecoder.isExpired(token!));
    }
    // TODO nav to the screen
    // Nav.replaceTo(context, Routes.dashboardRoute);
    return;
  }

  goToLoginIfExpire(bool isExpired) {
    if (isExpired) {
      _appPrefs.removeIsUserLoggedInStatus();
      _appPrefs.removeToken();
      initChooseServerModule();
      // navigate to login
      // TODO nav to the screen
      // Nav.replaceTo(context, Routes.loginRoute);
      return;
    }
  }

  reLogin() {
    _appPrefs.getSelectedServer().then((isChosedServer) {
      if (isChosedServer != Constants.nullValue) {
        initChooseServerModule();
        // navigate to login
        // TODO nav to the screen
        // Nav.replaceTo(context, Routes.loginRoute);
      } else {
        // TODO nav to the screen
        // Nav.replaceTo(context, Routes.chooseServerRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(ImageAssets.mainLogo),
        const Spacer(),
        SvgPicture.asset(ImageAssets.secondaryLogo),
        SvgPicture.asset(ImageAssets.teritaryLogo),
      ],
    );
  }
}
