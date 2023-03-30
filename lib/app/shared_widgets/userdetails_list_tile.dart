import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_status_vals.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';

class UserDetailsListTile extends StatelessWidget {
  final List<CardElement>? list;
  const UserDetailsListTile({
    super.key,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list!
          .map(
            (e) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    e.title == AppStrings.usersStatus
                        ? Container(
                            width: AppSize.s5,
                            height: AppSize.s56,
                            margin: const EdgeInsets.only(right: AppSize.s20),
                            decoration: BoxDecoration(
                              color: getStatusColor(e.subtitle),
                              borderRadius: BorderRadius.circular(AppSize.s5),
                            ),
                          )
                        : Container(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e.title,
                          style: StylesManager.getRegularStyle(
                            color: ColorManager.greyNeutral,
                            fontSize: FontSize.sSubtitle2,
                          ),
                        ),
                        const SizedBox(height: AppSize.s5),
                        Text(
                          e.subtitle.isNotEmpty ? e.subtitle : Constants.none,
                          style: StylesManager.getRegularStyle(
                            color: ColorManager.whiteNeutral,
                            fontSize: FontSize.sSubtitle1,
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
    );
  }
}
