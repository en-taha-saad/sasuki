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
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
            // TODO import the route
            Nav.replaceTo(context, Routes.loginRoute);
            return;
          }
        }
        // TODO import the route
        Nav.replaceTo(context, Routes.dashboardRoute);
        return;
      } else {
        _appPrefs.getSelectedServer().then((isChosedServer) {
          if (isChosedServer != null) {
            initChooseServerModule();
            // navigate to login
            // TODO import the route
            Nav.replaceTo(context, Routes.loginRoute);
          } else {
            // TODO import the route
            Nav.replaceTo(context, Routes.chooseServerRoute);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: AppSize.s0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Center(
            child: Image.asset(
              ImageAssets.sasukiLogo,
              height: AppSize.s138,
              width: AppSize.s265,
            ),
          ),
          Center(child: SvgPicture.asset(ImageAssets.backgroundSvg)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
