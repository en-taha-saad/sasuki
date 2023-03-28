import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? assetName;
  final String? name;
  final MainAxisSize? mainAxisSize;
  const ElevatedButtonWidget({
    this.onPressed,
    this.assetName,
    this.name,
    this.mainAxisSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: ColorManager.greyNeutral.withOpacity(
            AppSize.s0point25,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          children: [
            Text(name!),
            assetName != Constants.nullValue
                ? const SizedBox(width: AppSize.s10)
                : Container(),
            assetName != Constants.nullValue
                ? SvgPicture.asset(
                    assetName!,
                    height: FontSize.sButtonPill,
                    width: FontSize.sButtonPill,
                    theme: const SvgTheme(
                      currentColor: ColorManager.whiteNeutral,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
