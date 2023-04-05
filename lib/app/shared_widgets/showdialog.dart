import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

showActionDialog(BuildContext context, Widget? child) {
  return showDialog(
    context: context,
    barrierColor: ColorManager.backgroundCenter.withOpacity(AppSize.s0point4),
    barrierDismissible: Constants.falseBool,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p15,
            vertical: AppPadding.p30,
          ),
          decoration: BoxDecoration(
            color: ColorManager.whiteNeutral,
            shape: BoxShape.rectangle,
            borderRadius: RadiusSizes.radius16,
          ),
          child: child,
        ),
      );
    },
  );
}
