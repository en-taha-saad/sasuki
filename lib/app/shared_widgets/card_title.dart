import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

Widget getCardTitle(
  icon,
  title,
  context, {
  color = ColorManager.whiteNeutral,
}) {
  return Container(
    color: color != ColorManager.whiteNeutral
        ? ColorManager.transparent
        : const Color(0xff2D3B60),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSize.s25,
      vertical: AppSize.s10,
    ),
    margin: const EdgeInsets.only(
      bottom: AppSize.s15,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: AppSize.s10),
          child: SvgPicture.asset(
            icon,
            theme: SvgTheme(
              currentColor: color,
            ),
            // ignore: deprecated_member_use
            color: color,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
              ),
        ),
      ],
    ),
  );
}
