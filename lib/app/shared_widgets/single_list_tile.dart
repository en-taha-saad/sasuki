import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_status_vals.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';

class SingleListTile extends StatelessWidget {
  final List<CardElement>? list;
  const SingleListTile({
    super.key,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m25),
      child: Column(
        children: list!
            .map(
              (e) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.title,
                           style: StylesManager.getRegularStyle(
                              color: ColorManager.greyNeutral2,
                              fontSize: FontSize.sSubtitle5,
                              height: AppSize.s1,
                            ),
                          ),
                          const SizedBox(height: AppSize.s5),
                          Text(
                            e.subtitle.isNotEmpty ? e.subtitle : Constants.none,
                            style: StylesManager.getRegularStyle(
                              color: e.title == AppStrings.usersStatus
                                  ? getStatusColor(e.subtitle)
                                  : ColorManager.whiteNeutral,
                              fontSize: FontSize.sSubtitle3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (e != list?.last)
                    Column(
                      children: [
                        Divider(
                          color: ColorManager.greyNeutral.withOpacity(
                            AppSize.s0point25,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
