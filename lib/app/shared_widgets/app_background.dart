import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';

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
        decoration: const BoxDecoration(color: ColorManager.secondary),
        child: child,
      ),
    );
  }
}
