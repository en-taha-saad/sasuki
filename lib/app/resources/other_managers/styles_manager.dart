import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontweight_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';

class StylesManager {
  static TextStyle getTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color = ColorManager.whiteNeutral,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: Constants.fontFamily,
      overflow: TextOverflow.fade,
      color: color,
      fontSize: fontSize,
      decoration: decoration,
      height: height,
      fontWeight: fontWeight,
    );
  }

// regular style
  static TextStyle getRegularStyle({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    double? height,
  }) {
    return getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightManager.regular,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

// medium style
  static TextStyle getMediumStyle({
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightManager.medium,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

// semibold style
  static TextStyle getSemiBoldStyle({
    double? fontSize,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightManager.semiBold,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

// bold style
  static TextStyle getBoldStyle({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
  }) {
    return getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightManager.bold,
      color: color,
      decoration: decoration,
    );
  }
}
