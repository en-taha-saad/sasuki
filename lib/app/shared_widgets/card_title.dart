import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

Widget getCardTitle(icon, title, context) {
  return Container(
    color: ColorManager.whiteNeutral.withOpacity(0.2),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSize.s15,
      vertical: AppSize.s10,
    ),
    margin: const EdgeInsets.only(
      bottom: AppSize.s20,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: AppSize.s10),
          child: SvgPicture.asset(
            icon,
            theme: const SvgTheme(
              currentColor: ColorManager.whiteNeutral,
            ),
            // ignore: deprecated_member_use
            color: ColorManager.whiteNeutral,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    ),
  );
}
