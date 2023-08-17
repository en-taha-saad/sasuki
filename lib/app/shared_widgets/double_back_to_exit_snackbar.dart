import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

SnackBar doubleBackToExitSnackBar() {
  return const SnackBar(
    backgroundColor: ColorManager.backgroundCenter,
    behavior: SnackBarBehavior.floating,
    content: Text(
      'Tap back again to leave',
      style: TextStyle(
        color: ColorManager.whiteNeutral,
        fontSize: AppSize.s16,
      ),
    ),
  );
}
