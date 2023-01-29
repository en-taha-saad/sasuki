import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sasuki/app/constants.dart';
import 'package:sasuki/app/resources/other_managers/theme_manager.dart';
import 'package:sasuki/app/resources/routes_manager/route_generator.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // named constructor
  MyApp._internal();

  int appState = Constants.zeroNum;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      navigatorKey: navigatorKey,
      theme: getApplicationTheme(),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: false,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        // background: Container(color: ColorManager.primary),
        // TODO add yourbackground here
      ),
    );
  }
}
