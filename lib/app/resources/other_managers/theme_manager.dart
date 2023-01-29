import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  /// TODO : add theme data
  return ThemeData(
      // // main colors
      // useMaterial3: true,
      // colorScheme: ColorScheme.light(
      //   primary: ColorManager.primary,
      //   secondary: ColorManager.white,
      // ),
      // // app bar theme
      // appBarTheme: AppBarTheme(
      //   backgroundColor: ColorManager.primary,
      //   centerTitle: true,
      //   elevation: AppSize.s10,
      //   shadowColor: ColorManager.black.withOpacity(AppOpacity.op25),
      //   iconTheme: IconThemeData(
      //     color: ColorManager.white,
      //     size: AppSize.s36,
      //   ),
      //   actionsIconTheme: IconThemeData(
      //     color: ColorManager.white,
      //     size: AppSize.s36,
      //   ),
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,
      //     statusBarIconBrightness: Brightness.light,
      //   ),
      //   titleTextStyle: getSemiBoldStyle(
      //     fontSize: FontSize.s28,
      //     color: ColorManager.white.withOpacity(AppOpacity.op70),
      //   ),
      // ),

      // // elevated button theme
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     padding: const EdgeInsets.symmetric(
      //       horizontal: AppSize.s16,
      //       vertical: AppSize.s10,
      //     ),
      //     textStyle: getRegularStyle(
      //       color: ColorManager.primary,
      //       fontSize: FontSize.s20,
      //     ),
      //     foregroundColor: ColorManager.primary,
      //     backgroundColor: ColorManager.white,
      //     shape: RoundedRectangleBorder(borderRadius: AppSize.radius10),
      //     disabledBackgroundColor: ColorManager.disabledElevatedButton,
      //     disabledForegroundColor: ColorManager.white.withOpacity(
      //       AppOpacity.op20,
      //     ),
      //     elevation: AppSize.s4,
      //   ),
      // ),

      // // text button theme
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     padding: const EdgeInsets.all(AppSize.s12),
      //     textStyle: getRegularStyle(
      //       color: ColorManager.white,
      //       fontSize: FontSize.s15,
      //     ),
      //     foregroundColor: ColorManager.white,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: AppSize.radius10,
      //       side: BorderSide(
      //         color: ColorManager.white,
      //         width: AppSize.s1_5,
      //       ),
      //     ),
      //     disabledBackgroundColor: ColorManager.primary.withOpacity(
      //       AppOpacity.op05,
      //     ),
      //     disabledForegroundColor: ColorManager.white.withOpacity(
      //       AppOpacity.op20,
      //     ),
      //     elevation: AppSize.s0,
      //   ),
      // ),

      // textSelectionTheme: TextSelectionThemeData(
      //   cursorColor: ColorManager.white,
      //   selectionColor: ColorManager.white.withOpacity(AppOpacity.op20),
      //   selectionHandleColor: ColorManager.transparent,
      // ),
      // // input decoration theme (text form field)
      // inputDecorationTheme: InputDecorationTheme(
      //   // content padding
      //   contentPadding: const EdgeInsets.all(AppPadding.p8),

      //   // hint style
      //   hintStyle: getRegularStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op40),
      //     fontSize: FontSize.s16,
      //   ),
      //   labelStyle: getMediumStyle(
      //     color: ColorManager.white.withOpacity(AppOpacity.op40),
      //     fontSize: FontSize.s16,
      //   ),
      //   errorStyle: getRegularStyle(color: ColorManager.orange),

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
      );
}
