import 'package:flutter/material.dart';

Route createRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (a, b, c) => widget,
    transitionsBuilder: (b, animation, a, child) {
      var tween = Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeIn));
      return SlideTransition(
        textDirection: TextDirection.rtl,
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
