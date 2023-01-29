import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';

class Nav {
  static void navTo(context, String routeName, [argument]) {
    String? currentRoute =
        ModalRoute.of(context)?.settings.arguments as String?;
    if (routeName == Routes.drawerRoute) {
      Navigator.of(context).pushNamed(routeName, arguments: currentRoute);
    } else {
      Navigator.of(context).pushNamed(routeName, arguments: argument);
    }
  }

  static void popRoute(context) => Navigator.of(context).pop();
  static void replaceTo(context, String routeName) => Navigator.of(context)
      .pushReplacementNamed(routeName, arguments: routeName);
}
