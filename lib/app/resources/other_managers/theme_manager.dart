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
    colorScheme: const ColorScheme.light(
      primary: ColorManager.primaryshade1,
      secondary: ColorManager.secondary,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p25,
          vertical: AppPadding.p10Point5,
        ),
        foregroundColor: ColorManager.whiteNeutral,
        backgroundColor: ColorManager.primaryshade1,
        textStyle: StylesManager.getSemiBoldStyle(
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
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p10Point5,
          horizontal: AppPadding.p25,
        ),
        textStyle: StylesManager.getSemiBoldStyle(
          fontSize: FontSize.sButton,
        ),
        foregroundColor: ColorManager.whiteNeutral,
      ),
    ),

    // text field cursor theme
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorManager.whiteNeutral,
      selectionColor: ColorManager.whiteNeutral,
      selectionHandleColor: ColorManager.transparent,
    ),

    textTheme: TextTheme(
      bodyLarge: StylesManager.getRegularStyle(
        color: ColorManager.whiteNeutral,
        fontSize: FontSize.sInputText,
      ),
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
      //   // enabled border style
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: ColorManager.white,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: AppSize.radius10,
      //   ),

      //   // focused border style
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: ColorManager.white,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: AppSize.radius10,
      //   ),

      //   // error border style
      //   errorBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: ColorManager.orange,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: AppSize.radius10,
      //   ),
      //   // focused border style
      //   focusedErrorBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: ColorManager.orange,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: AppSize.radius10,
      //   ),
      // ),

      // // dashboard  subtitles

      // textTheme: TextTheme(

      //   // dashboard header title
      //   displayLarge: getSemiBoldStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op70),
      //     fontSize: FontSize.s40,
      //   ),

      //   displayMedium: getSemiBoldStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op70),
      //     fontSize: FontSize.s26,
      //   ),

      //   // dashboard title
      //   headlineLarge: getMediumStyle(
      //     color: ColorManager.white,
      //     fontSize: FontSize.s25,
      //   ),

      //   // servTitle
      //   headlineMedium: getMediumStyle(
      //     color: ColorManager.white,
      //     fontSize: FontSize.s20,
      //   ),

      //   // dashboard headers titles
      //   headlineSmall: getRegularStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op70),
      //     fontSize: FontSize.s20,
      //   ),

      //   // dashboard titles and values
      //   titleLarge: getSemiBoldStyle(
      //     color: ColorManager.white,
      //     fontSize: FontSize.s16,
      //   ),

      //   // welcome && servCancel
      //   titleMedium: getMediumStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op70),
      //     fontSize: FontSize.s16,
      //   ),

      //   // headers labels
      //   titleSmall: getMediumStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op70),
      //     fontSize: FontSize.s12,
      //   ),
      //   // dashboard  subtitles
      //   bodyLarge: getRegularStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op80),
      //     fontSize: FontSize.s12,
      //   ),

      //   // dropdown menu items
      //   bodyMedium: getBoldStyle(
      //     color: ColorManager.primary,
      //     fontSize: FontSize.s16,
      //   ),

      //   bodySmall: getRegularStyle(
      //     color: ColorManager.primary,
      //     fontSize: FontSize.s12,
      //   ),
      // ),

      // ///
      // listTileTheme: ListTileThemeData(
      //   contentPadding: const EdgeInsets.symmetric(
      //     horizontal: AppPadding.p20,
      //     vertical: AppPadding.p4,
      //   ),
      //   dense: true,
      //   shape: RoundedRectangleBorder(
      //     side: BorderSide(
      //       color: ColorManager.white.withOpacity(AppOpacity.op30),
      //       width: AppSize.s0_5,
      //     ),
      //   ),
      //   tileColor: ColorManager.black.withOpacity(AppOpacity.op30),
      //   horizontalTitleGap: AppSize.s20,
      // ),

      // drawerTheme: const DrawerThemeData(),
    ),
  );
}
