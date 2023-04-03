import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class TextButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? assetName;
  final String? name;
  final bool? justText;
  final MainAxisSize? mainAxisSize;
  const TextButtonWidget({
    this.onPressed,
    this.assetName,
    this.name,
    this.mainAxisSize,
    this.justText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s48,
      decoration: justText == Constants.trueBool
          ? Constants.nullValue
          : BoxDecoration(
              borderRadius: RadiusSizes.radius12,
              border: Border.all(
                color: ColorManager.whiteNeutral,
                width: AppSize.s1,
              ),
            ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          children: [
            assetName != Constants.nullValue
                ? SvgPicture.asset(
                    assetName!,
                    height: FontSize.sButtonLink,
                    width: FontSize.sButtonLink,
                    theme: const SvgTheme(
                      currentColor: ColorManager.whiteNeutral,
                    ),
                      // ignore: deprecated_member_use
                      color: ColorManager.whiteNeutral,
                  )
                : Container(),
            const SizedBox(width: AppSize.s10),
            Text(name!),
          ],
        ),
      ),
    );
  }
}
