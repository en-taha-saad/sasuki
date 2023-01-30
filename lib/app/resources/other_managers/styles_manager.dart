// TODO : add text syles
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontweight_manager.dart';

class StylesManager {
  static TextStyle getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: Constants.fontFamily,
      color: color,
      fontWeight: fontWeight,
    );
  }

// regular style
  TextStyle getRegularStyle({
    required double fontSize,
    required Color color,
  }) {
    return getTextStyle(
      fontSize,
      FontWeightManager.regular,
      color,
    );
  }

// medium style
  TextStyle getMediumStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return getTextStyle(
      fontSize,
      FontWeightManager.medium,
      color,
    );
  }

// semibold style
  TextStyle getSemiBoldStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return getTextStyle(
      fontSize,
      FontWeightManager.semiBold,
      color,
    );
  }

// bold style
  TextStyle getBoldStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return getTextStyle(
      fontSize,
      FontWeightManager.bold,
      color,
    );
  }
}
