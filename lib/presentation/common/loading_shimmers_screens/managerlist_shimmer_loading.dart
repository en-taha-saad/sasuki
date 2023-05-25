import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
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
        Container(
          color: ColorManager.primaryshade1,
          child: Column(
            children: [
              AppSize.statusBarHeight(context),
              const SizedBox(height: AppSize.s20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            Container(),
                          ],
                        ),
                        Center(
                          child: Text(
                            AppStrings.managersListScreen,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 18,
                                ),
                            textAlign: TextAlign.center,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s15),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getScreenWidth(context) * 0.6,
                child: _getSearchTextField(context),
              ),
              Container(),
              Container(),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s15),
        Expanded(
          child: _getManagersList(),
        ),
      ],
    );
  }

  _getSearchTextField(context) {
    return Stack(
      children: [
        TextFormField(
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.whiteNeutral,
              ),
          enabled: Constants.falseBool,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: RadiusSizes.radius12,
            ),
            hintText: AppStrings.usersSearchmanagers,
            fillColor: const Color(0xff3D4E78),
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
