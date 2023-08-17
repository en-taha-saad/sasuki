import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_choose_server_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/shared_funs/change_status_bar_color.dart';
import 'package:sasuki/app/shared_widgets/footer.dart';

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
    changeStatusBarColor();

    _startDelay();
    super.initState();
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: Constants.splashDelay), _goNext);
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
    Navigator.of(context).popUntil((route) => route.isFirst);
    Nav.replaceTo(context, Routes.dashboardRoute);
    return;
  }

  reLogin() {
    _appPrefs.getSelectedServer().then((isChosedServer) {
      if (isChosedServer != Constants.nullValue) {
        initChooseServerModule();
        // navigate to login
        Navigator.of(context).popUntil((route) => route.isFirst);
        Nav.replaceTo(context, Routes.loginRoute);
      } else {
        Nav.replaceTo(context, Routes.chooseServerRoute);
      }
    });
  }

  goToLoginIfExpire(bool isExpired) {
    if (isExpired) {
      _appPrefs.removeIsUserLoggedInStatus();
      _appPrefs.removeToken();
      initChooseServerModule();
      // navigate to login
      Navigator.of(context).popUntil((route) => route.isFirst);
      Nav.replaceTo(context, Routes.loginRoute);
      return;
    }
  }

  @override
  void dispose() {
    changeStatusBarColor();

    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff16558F),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              ImageAssets.mainLogo,
              height: 75,
              width: 144.96,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: getScreenFooter(),
          ),
        ],
      ),
    );
  }
}
