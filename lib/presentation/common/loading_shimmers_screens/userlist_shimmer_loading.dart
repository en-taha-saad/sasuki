import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/single_user_card.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';
import 'package:sasuki/app/shared_widgets/single_user_card_statistics.dart';

class UserListShimmerLoading extends StatelessWidget {
  const UserListShimmerLoading({super.key});

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
                            AppStrings.usersUsersList,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    const SingleUserCardStatistics(
                      isShimmer: Constants.trueBool,
                      totalUsers: Constants.dash,
                      activeUsers: Constants.dash,
                      expiredUsers: Constants.dash,
                      onlineUsers: Constants.dash,
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
                child: _getSearchTextField(),
              ),
              Container(),
              Container(),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s15),
        Expanded(
          child: _getUsersList(),
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
            fillColor: Color(0xff3D4E78),
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

  Widget _getUsersList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _singleUser(),
          _singleUser(),
          _singleUser(),
          _singleUser(),
          _singleUser(),
          _singleUser(),
          _singleUser(),
          _singleUser(),
          _singleUser(),
          _singleUser(),
        ],
      ),
    );
  }

  Widget _singleUser() {
    return const SingleUserCard(
      isShimmer: Constants.trueBool,
      fullName: Constants.dash,
      profileName: Constants.dash,
      balance: Constants.dash,
      expireOn: Constants.dash,
      status: Constants.dash,
      statusColor: ColorManager.greyshade1,
      username: Constants.dash,
    );
  }
}
