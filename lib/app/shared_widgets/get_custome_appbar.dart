import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';

Container getCustomAppBar(context, String title, bool isScreenSecondary,
    [bool? isDashboard, cancelTimer]) {
  return Container(
    color: ColorManager.primaryshade1,
    child: Stack(
      alignment: isDashboard == true
          ? Alignment.center
          : AlignmentDirectional.topStart,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: AppMargin.m14,
            top: AppMargin.m8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                    isScreenSecondary ? IconsAssets.back : IconsAssets.menu),
                onPressed: isScreenSecondary
                    ? () => Nav.popRoute(context)
                    : () {
                        cancelTimer;
                        Nav.navTo(context, Routes.drawerRoute);
                      },
              ),
              Container(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppMargin.m20,
          ),
          child: Center(
            child: Text(
              title,
              style: isDashboard == true
                  ? Theme.of(context).textTheme.displayMedium
                  : Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                      ),
            ),
          ),
        ),
      ],
    ),
  );
}
