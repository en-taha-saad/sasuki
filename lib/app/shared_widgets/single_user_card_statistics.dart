import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/text_shimmer.dart';

class SingleUserCardStatistics extends StatelessWidget {
  const SingleUserCardStatistics({
    this.totalUsers,
    this.activeUsers,
    this.expiredUsers,
    this.onlineUsers,
    this.isShimmer,
    super.key,
  });
  final String? totalUsers;
  final String? activeUsers;
  final String? expiredUsers;
  final String? onlineUsers;
  final bool? isShimmer;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: AppSize.s25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: AppSize.s15,
              top: AppSize.s13,
              bottom: AppSize.s13,
            ),
            child: SvgPicture.asset(
              IconsAssets.statusup,
              height: AppSize.s20,
              width: AppSize.s20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.totalUsers,
                    style: StylesManager.getRegularStyle(
                      color: ColorManager.greyNeutral3,
                      fontSize: FontSize.sBody3,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSize.s15),
                    child: isShimmer != Constants.nullValue &&
                            isShimmer != Constants.falseBool
                        ? const ShimmerText(
                            baseColor: ColorManager.whiteNeutral,
                            highlightColor: ColorManager.backgroundCenter,
                            width: AppSize.s30,
                          )
                        : Text(
                            totalUsers!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: FontSize.sHeading2,
                                ),
                          ),
                  ),
                ],
              ),
              Row(
                children: [
                  singleUserCardStatisticsInform(
                    context,
                    activeUsers,
                    AppStrings.activeUsers,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: AppSize.s55),
                    child: singleUserCardStatisticsInform(
                      context,
                      expiredUsers,
                      AppStrings.expiredUsers,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: AppSize.s55),
                    child: singleUserCardStatisticsInform(
                      context,
                      onlineUsers,
                      AppStrings.onlineUsers,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget singleUserCardStatisticsInform(
    context,
    String? value,
    String? label,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isShimmer != Constants.nullValue && isShimmer != Constants.falseBool
            ? const ShimmerText(
                baseColor: ColorManager.whiteNeutral,
                highlightColor: ColorManager.backgroundCenter,
                width: AppSize.s30,
              )
            : Text(
                value!,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: FontSize.sHeading4,
                    ),
              ),
        Text(
          label!,
          style: StylesManager.getRegularStyle(
            color: ColorManager.greyNeutral3,
            fontSize: FontSize.sBody3,
          ),
        ),
      ],
    );
  }
}
