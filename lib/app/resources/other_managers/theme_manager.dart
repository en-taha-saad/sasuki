import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // base theme
    useMaterial3: Constants.trueBool,
    fontFamily: Constants.fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: ColorManager.primaryshade1,
      secondary: ColorManager.secondary,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(ColorManager.whiteNeutral),
      shape: RoundedRectangleBorder(borderRadius: RadiusSizes.radius6),
      checkColor:
          MaterialStateProperty.all<Color>(ColorManager.backgroundCenter),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),


    // card button theme
    cardTheme: CardTheme(
      color: ColorManager.primaryshade3,
      shape: RoundedRectangleBorder(
        borderRadius: RadiusSizes.radius12,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppPadding.p25,
      ),
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p25,
          vertical: AppPadding.p10Point5,
        ),
        disabledBackgroundColor: ColorManager.whiteNeutral.withOpacity(0.30),
        foregroundColor: ColorManager.whiteNeutral,
        backgroundColor: ColorManager.primaryshade1,
        textStyle: StylesManager.getMediumStyle(
          fontSize: FontSize.sButton,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: RadiusSizes.radius12,
        ),
      ),
    ),

    // text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10Point5),
        textStyle: StylesManager.getMediumStyle(
          fontSize: FontSize.sButton,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: RadiusSizes.radius12,
        ),
        foregroundColor: ColorManager.whiteNeutral,
        disabledForegroundColor: ColorManager.greyNeutral,
      ),
    ),

    // text field cursor theme
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorManager.greyNeutral,
      selectionColor: ColorManager.greyNeutral,
      selectionHandleColor: ColorManager.transparent,
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      filled: Constants.trueBool,
      isDense: Constants.trueBool,
      fillColor: ColorManager.primaryshade3,
      border: OutlineInputBorder(
        borderRadius: RadiusSizes.radius12,
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p12,
      ),
      hintStyle: StylesManager.getRegularStyle(
        color: ColorManager.greyNeutral,
        fontSize: FontSize.sInputText,
      ),
      errorStyle: StylesManager.getRegularStyle(
        color: ColorManager.orangeAnnotations,
        fontSize: FontSize.sError,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: RadiusSizes.radius12,
        borderSide: const BorderSide(
          color: ColorManager.orangeAnnotations,
          width: AppSize.s1point5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: RadiusSizes.radius12,
        borderSide: const BorderSide(
          color: ColorManager.orangeAnnotations,
          width: AppSize.s1point5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: RadiusSizes.radius12,
        borderSide: const BorderSide(
          color: ColorManager.whiteNeutral,
          width: AppSize.s1point5,
        ),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      // // heading 1
      // displayLarge: StylesManager.getMediumStyle(
      //   fontSize: FontSize.sHeading1,
      // ),

      // heading 2
      displayMedium: StylesManager.getSemiBoldStyle(
        fontSize: FontSize.sHeading2,
        height: AppSize.s1_5,
      ),

      // // heading 3
      // displaySmall: StylesManager.getBoldStyle(
      //   fontSize: FontSize.sHeading3,
      // ),

      ////////////// heading 5
      headlineMedium: StylesManager.getMediumStyle(
        fontSize: FontSize.sHeading5,
      ),

      ////////////// input label
      labelLarge: StylesManager.getMediumStyle(
        fontSize: FontSize.sInputLabel,
      ),

      ///////////// button
      headlineSmall: StylesManager.getMediumStyle(
        fontSize: FontSize.sButton,
      ),

      ////////////// badge 2
      labelSmall: StylesManager.getMediumStyle(
        fontSize: FontSize.sBadge1,
      ),

      ///////////// heading 6
      titleLarge: StylesManager.getMediumStyle(
        fontSize: FontSize.sHeading6,
      ),

      ////////// caption 1, 2
      bodySmall: StylesManager.getSemiBoldStyle(
        fontSize: FontSize.sCaption1,
      ),




      // subtitle 1
      titleMedium: StylesManager.getMediumStyle(
        fontSize: FontSize.sSubtitle1,
      ),

      // subtitle 2,
      titleSmall: StylesManager.getMediumStyle(
        fontSize: FontSize.sSubtitle2,
      ),

      // badge 1
      labelMedium: StylesManager.getRegularStyle(
        fontSize: FontSize.sBadge1,
      ),


      // bodyText1 (input text), body2
      bodyLarge: StylesManager.getRegularStyle(
        fontSize: FontSize.sInputText,
      ),

      // bodyText2
      bodyMedium: StylesManager.getRegularStyle(
        fontSize: FontSize.sBadge1,
      ),

    ),

    // divider theme
    dividerTheme:  DividerThemeData(
      color: ColorManager.greyNeutral.withOpacity(0.25),
      thickness: AppSize.s1,
      space: AppSize.s25,
    ),

    // single dashboard inform
    listTileTheme: const ListTileThemeData(
      textColor: ColorManager.whiteNeutral,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppPadding.p0,
        vertical: AppPadding.p0,
      ),
    ),
  );
}
