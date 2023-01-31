import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class CircleElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  const CircleElevatedButton({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(AppSize.s7),
      ),
      child: SvgPicture.asset(
        IconsAssets.add,
        height: FontSize.sHeading2,
        width: FontSize.sHeading2,
        color: ColorManager.whiteNeutral,
      ),
    );
  }
}
