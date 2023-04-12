import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';

Widget getActionDialogContent(
  BuildContext context,
  Widget child,
  String buttonText,
  String dialogTitle,
  String dialogTitleIcon,
  Function()? onPressed,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: AppMargin.m15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: AppMargin.m10),
              child: SvgPicture.asset(
                dialogTitleIcon,
                height: AppSize.s20,
                width: AppSize.s20,
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral5,
              ),
            ),
            Text(
              dialogTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: ColorManager.greyNeutral5,
                  ),
            ),
          ],
        ),
      ),
      Container(
          margin: const EdgeInsets.only(
            bottom: AppMargin.m20,
          ),
          child: const Divider(
            color: ColorManager.greyNeutral,
            height: AppSize.s1,
            thickness: AppSize.s1,
          )),
      child,
      Container(
        margin: const EdgeInsets.only(top: AppMargin.m15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Nav.popRoute(context),
              child: Text(
                AppStrings.cancelButton,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: ColorManager.blackNeutral,
                    ),
              ),
            ),
            ElevatedButtonWidget(
              name: buttonText,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    ],
  );
}
