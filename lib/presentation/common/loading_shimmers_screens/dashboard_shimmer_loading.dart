import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';
import 'package:sasuki/app/shared_widgets/dashboard_list_tile.dart';
import 'package:sasuki/app/shared_widgets/text_shimmer.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';

class DashboardShimmerLoading extends StatelessWidget {
  const DashboardShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isSecondAppBackground: Constants.falseBool,
      child: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppSize.statusBarHeight(context),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(IconsAssets.menu),
                    const ShimmerText(
                      baseColor: ColorManager.whiteNeutral,
                      highlightColor: ColorManager.greyNeutral,
                      width: AppSize.s50,
                    ),
                    Container(),
                  ],
                ),
                const SizedBox(height: AppSize.s20),
                Text(
                  AppStrings.welcome,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                            ColorManager.whiteNeutral.withOpacity(AppSize.s0_5),
                        height: AppSize.s1_5,
                      ),
                ),
                const ShimmerText(
                  baseColor: ColorManager.whiteNeutral,
                  highlightColor: ColorManager.backgroundCenter,
                  width: AppSize.s50,
                ),
                const SizedBox(height: AppSize.s10),
                const ShimmerText(
                  baseColor: ColorManager.greyNeutral,
                  highlightColor: ColorManager.backgroundCenter,
                  width: AppSize.s40,
                ),
                Text(
                  AppStrings.availableBalance,
                  style: StylesManager.getMediumStyle(
                    color: ColorManager.whiteNeutral.withOpacity(
                      AppSize.s0_5,
                    ),
                    height: AppSize.s1_5,
                    fontSize: FontSize.sSubtitle5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s25),
          Container(
            width: MediaQuery.of(context).size.width,
            child: _getDashboardContent(context),
            decoration: const BoxDecoration(
              color: ColorManager.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s35),
                topRight: Radius.circular(AppSize.s35),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getDashboardContent(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _getCardTitle(
            IconsAssets.dashboardUserStatistics,
            AppStrings.dashboardUsersStatistics,
            context,
          ),
          DashboardListTile(
            shimmerText: const ShimmerText(
              baseColor: ColorManager.whiteNeutral,
              highlightColor: ColorManager.backgroundCenter,
              width: AppSize.s20,
            ),
            list: [
              CardElement(
                AppStrings.dashboardUsers,
                AppStrings.dashboardTotalnumberofusers,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardOnlineUsers,
                AppStrings.dashboardNumberofonlineusers,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardActiveUsers,
                AppStrings.dashboardNumberofactiveusers,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardExpiredUsers,
                AppStrings.dashboardNumberofexpiredusers,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardAboutToExpire,
                AppStrings.dashboardUsersactivebutgoingtoexpiretoday,
                Constants.dash,
              ),
            ],
          ),
          _getCardTitle(
            IconsAssets.dashboardSalesAndFinance,
            AppStrings.dashboardSalesFinance,
            context,
          ),
          DashboardListTile(
            shimmerText: const ShimmerText(
              baseColor: ColorManager.whiteNeutral,
              highlightColor: ColorManager.greyNeutral,
              width: AppSize.s20,
            ),
            list: [
              CardElement(
                AppStrings.dashboardNewRegistrations,
                AppStrings.dashboardUsersaddedthismonth,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardActivations,
                AppStrings.dashboardUsersactivatedthismonth,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardSales,
                AppStrings.dashboardTotalsalesforthismonth,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardProfits,
                AppStrings.dashboardmonthlyprofits,
                Constants.dash,
              ),
              CardElement(
                AppStrings.dashboardRewardPoints,
                AppStrings.dashboardrewardpointsbalance,
                Constants.dash,
              ),
            ],
          ),
          const SizedBox(height: AppSize.s50),
        ],
      ),
    );
  }

  Widget _getCardTitle(icon, title, context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s35),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: AppSize.s15),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: ColorManager.greyNeutral,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Divider(
          color: ColorManager.greyNeutral.withOpacity(
            AppSize.s0point25,
          ),
        ),
        const SizedBox(height: AppSize.s15),
      ],
    );
  }
}
