import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;
  final bool? resizeToAvoidBottomInset;
  final bool? isSecondAppBackground;

  const AppBackground({
    this.child,
    this.resizeToAvoidBottomInset,
    this.isSecondAppBackground,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: Constants.trueBool,
      extendBodyBehindAppBar: Constants.trueBool,
      appBar: Constants.nullValue,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 1.0],
            colors: [
              Color(0xFF0C3F6A),
              Color(0xFF0F1644),
            ],
            transform: GradientRotation(0.03),
          ),
          // gradient: isSecondAppBackground == Constants.falseBool
          //     ? const RadialGradient(
          //         focal: Alignment(-AppSize.s0_5, AppSize.s0_9),
          //         center: Alignment(-AppSize.s0_5, AppSize.s0_1),
          //         focalRadius: AppSize.s0_5,
          //         radius: AppSize.s1_7,
          //         stops: [
          //           AppSize.s0_2,
          //           AppSize.s0_7,
          //         ],
          //         colors: [
          //           ColorManager.backgroundCenter,
          //           ColorManager.primaryshade1,
          //           // Color(0xff0C3F6A),
          //         ],
          //       )
          //     : const LinearGradient(
          //         begin: Alignment(-5.7, 1),
          //         end: Alignment(AppSize.s0point95, 2.5),
          //         colors: [
          //           ColorManager.backgroundCenter,
          //           ColorManager.primaryshade1,

          //           // Color(0xff0C3F6A),
          //         ],
          //       ),
        ),
        child: child,
      ),
    );
  }
}
