import 'package:flutter/services.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';

changeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorManager.transparent,
      systemNavigationBarColor: ColorManager.secondary,
      systemNavigationBarDividerColor: ColorManager.secondary,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
