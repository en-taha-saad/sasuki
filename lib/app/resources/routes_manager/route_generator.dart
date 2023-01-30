import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.drawerRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: Center(
              child: Text(
                Routes.drawerRoute,
              ),
            ),
          ),
          settings: settings,
        );
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: Center(
              child: Text(
                Routes.splashRoute,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: Constants.fontFamily,
                ),
              ),
            ),
          ),
          settings: settings,
        );
      // TODO add your routes here
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const AppBackground(
        child: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
