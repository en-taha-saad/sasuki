import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? assetName;
  final MainAxisSize? mainAxisSize;
  const ElevatedButtonWidget({
    this.onPressed,
    this.assetName,
    this.mainAxisSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        children: [
          const Text(Routes.splashRoute),
          const SizedBox(width: AppSize.s10),
          SvgPicture.asset(
            assetName!,
            height: FontSize.sButtonPill,
            width: FontSize.sButtonPill,
            color: ColorManager.whiteNeutral,
          ),
        ],
      ),
    );
  }
}
