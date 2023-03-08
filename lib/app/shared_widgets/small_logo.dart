import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

Image getScreenSmallLogo() {
  return Image.asset(
    ImageAssets.mainLogo,
    width: AppSize.s120,
    height: AppSize.s80,
  );
}
