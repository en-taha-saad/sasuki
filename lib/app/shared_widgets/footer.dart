import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

Stack getScreenFooter() {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      SvgPicture.asset(ImageAssets.teritaryLogo),
      Container(
        margin: const EdgeInsets.only(bottom: AppMargin.m4),
        child: SvgPicture.asset(
          ImageAssets.secondaryLogo,
          height: AppSize.s60,
          width: AppSize.s120,
        ),
      ),
    ],
  );
}
