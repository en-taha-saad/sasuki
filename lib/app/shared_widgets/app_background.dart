import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;
  const AppBackground({
    this.child,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: Constants.trueBool,
      extendBodyBehindAppBar: Constants.trueBool,
      appBar: Constants.nullValue,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-AppSize.s0point95, AppSize.s1),
            end: Alignment(AppSize.s0point95, AppSize.s1),
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
