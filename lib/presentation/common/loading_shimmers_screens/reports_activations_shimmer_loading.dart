import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/single_activation_card.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';

class ReportsActivationsShimmerLoading extends StatelessWidget {
  const ReportsActivationsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isSecondAppBackground: Constants.falseBool,
      child: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(context) {
    return Container(
      color: ColorManager.secondary,
      child: Column(
        children: [
          Container(
            color: ColorManager.primaryshade1,
            child: Column(
              children: [
                AppSize.statusBarHeight(context),
                Container(
                  margin: const EdgeInsets.only(
                    right: AppMargin.m25,
                    left: AppMargin.m25,
                    bottom: AppMargin.m25,
                  ),
                  child: _getActivationAppBar(context),
                ),
              ],
            ),
          ),
          Container(
            color: ColorManager.whiteNeutral.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s20,
              vertical: AppSize.s10,
            ),
            margin: const EdgeInsets.only(
              bottom: AppSize.s20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: AppSize.s10),
                      child: SvgPicture.asset(
                        IconsAssets.tickcircle,
                        theme: const SvgTheme(
                          currentColor: ColorManager.whiteNeutral,
                        ),
                        // ignore: deprecated_member_use
                        color: ColorManager.whiteNeutral,
                      ),
                    ),
                    Text(
                      AppStrings.activationReports,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: ColorManager.whiteNeutral,
                              ),
                    ),
                  ],
                ),
                InkWell(
                  child: SvgPicture.asset(
                    IconsAssets.filter,
                    theme: const SvgTheme(
                      currentColor: ColorManager.whiteNeutral,
                    ),
                    // ignore: deprecated_member_use
                    color: ColorManager.whiteNeutral,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _getActivationListContent(),
          ),
        ],
      ),
    );
  }

  AppBar _getActivationAppBar(context) {
    return AppBar(
     
      toolbarHeight: 40,
      titleSpacing: 0,
      leading: Container(
        margin: const EdgeInsets.only(
          right: AppMargin.m30,
        ),
        child: SvgPicture.asset(IconsAssets.back),
      ),
      title: Text(
        AppStrings.drawerReports,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
            ),
      ),
    );
  }

  Widget _getActivationListContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
          _singleActivation(),
        ],
      ),
    );
  }

  Widget _singleActivation() {
    return const SingleActivationCard(
      isShimmer: Constants.trueBool,
    );
  }
}
