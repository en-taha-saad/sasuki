import 'package:flutter/services.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';

applyScreenSettings() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorManager.transparent,
      systemNavigationBarColor: ColorManager.secondary,
      systemNavigationBarDividerColor: ColorManager.secondary,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
