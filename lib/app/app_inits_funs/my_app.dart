import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sasuki/app/app_inits_funs/app_screen_settings.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/theme_manager.dart';
import 'package:sasuki/app/resources/routes_manager/route_generator.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';

class MyApp extends StatelessWidget {
  // named constructor
  MyApp._internal();
  final int appState = Constants.zeroNum.toInt();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;
  @override
  Widget build(BuildContext context) {
    applyScreenSettings();
    return MaterialApp(
      debugShowCheckedModeBanner: Constants.falseNum,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      navigatorKey: navigatorKey,
      theme: getApplicationTheme(),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: Constants.maxWidthScreen,
        minWidth: Constants.minWidthScreen,
        defaultScale: Constants.falseNum,
        breakpoints: [
          const ResponsiveBreakpoint.resize(
            Constants.mobileScreenBreakpoint,
            name: MOBILE,
          ),
          const ResponsiveBreakpoint.autoScale(
            Constants.tabletScreenBreakpoint,
            name: TABLET,
          ),
          const ResponsiveBreakpoint.resize(
            Constants.desktopScreenBreakpoint,
            name: DESKTOP,
          ),
        ],
      ),
    );
  }
}
