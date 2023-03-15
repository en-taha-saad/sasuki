import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_add_server_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_choose_server_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_login_module.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';
import 'package:sasuki/presentation/add_server/view/add_server_view.dart';
import 'package:sasuki/presentation/choose_server/view/choose_server_view.dart';
import 'package:sasuki/presentation/login/view/login_view.dart';
import 'package:sasuki/presentation/splash/splash_view.dart';

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
            child: SplashView(),
          ),
          settings: settings,
        );
      case Routes.chooseServerRoute:
        initChooseServerModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ChooseServerView(),
          ),
        );
      case Routes.addServerRoute:
        initAddServerModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            resizeToAvoidBottomInset: Constants.falseBool,
            child: AddServerView(),
          ),
        );
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            resizeToAvoidBottomInset: Constants.trueBool,
            child: LoginView(),
          ),
        );
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
