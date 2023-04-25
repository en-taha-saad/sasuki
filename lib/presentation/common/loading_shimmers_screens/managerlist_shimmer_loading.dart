import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/single_manager_card.dart';
import 'package:sasuki/app/shared_widgets/single_manager_card_statistics.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';

class ManagerListShimmerLoading extends StatelessWidget {
  const ManagerListShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isSecondAppBackground: Constants.falseBool,
      child: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(context) {
    return Column(
      children: [
        AppSize.statusBarHeight(context),
        const SizedBox(height: AppSize.s20),
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
                  Container(
                    padding: const EdgeInsets.all(AppSize.s10),
                    child: SvgPicture.asset(IconsAssets.menu),
                  ),
                  Text(
                    AppStrings.managersListScreen,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  Container(),
                ],
              ),
              const SizedBox(height: AppSize.s20),
              const SingleManagerCardStatistics(
                isShimmer: Constants.trueBool,
                totalManagers: Constants.dash,
              ),
              const SizedBox(height: AppSize.s15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: getScreenWidth(context) * 0.6,
                    child: _getSearchTextField(),
                  ),
                  SvgPicture.asset(
                    IconsAssets.filter,
                    width: AppSize.s18,
                    height: AppSize.s18,
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppPadding.p7),
                    decoration: const BoxDecoration(
                      color: ColorManager.primaryshade1,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      IconsAssets.add,
                      width: AppSize.s24,
                      height: AppSize.s24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s15),
            ],
          ),
        ),
        Expanded(
          child: _getManagersList(),
        ),
      ],
    );
  }

  _getSearchTextField() {
    return Stack(
      children: [
        TextFormField(
          enabled: Constants.falseBool,
          decoration: const InputDecoration(
            hintText: AppStrings.usersSearchusers,
            fillColor: ColorManager.greyshade1,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppMargin.m10,
            right: AppMargin.m12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconsAssets.clearInput,
                theme: const SvgTheme(
                  currentColor: ColorManager.greyNeutral,
                ),
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral,
              ),
              SvgPicture.asset(
                height: AppSize.s18,
                width: AppSize.s18,
                IconsAssets.search,
                theme: const SvgTheme(
                  currentColor: ColorManager.greyNeutral,
                ),
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getManagersList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _singleManager(),
          _singleManager(),
          _singleManager(),
          _singleManager(),
          _singleManager(),
          _singleManager(),
          _singleManager(),
          _singleManager(),
          _singleManager(),
          _singleManager(),
        ],
      ),
    );
  }

  Widget _singleManager() {
    return const SingleManagerCard(
      isShimmer: Constants.trueBool,
      fullName: Constants.dash,
      balance: Constants.dash,
      permissionGroup: Constants.dash,
      usersCount: Constants.dash,
      status: Constants.dash,
      statusColor: ColorManager.greyshade1,
      username: Constants.dash,
    );
  }
}
