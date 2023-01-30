import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;
  const AppBackground({
    this.child,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: Constants.twoFiveDouble,
            center: Alignment(
              Constants.zeroDouble,
              Constants.sevenDouble,
            ),
            focal: Alignment(
              -Constants.oneNum,
              Constants.sevenDouble,
            ),
            focalRadius: Constants.oneDouble,
            stops: [Constants.twoDouble, Constants.sevenDouble],
            colors: [
              ColorManager.backgroundCenter,
              ColorManager.backgroundCorners,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
