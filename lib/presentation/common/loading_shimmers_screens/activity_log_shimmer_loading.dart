import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/single_activity_log_card.dart';


class ActivityLogViewShimmerLoading extends StatelessWidget {
  const ActivityLogViewShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isSecondAppBackground: Constants.falseBool,
      child: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff1B2A52),
      ),
      child: Column(
        children: [
          Container(
            color: ColorManager.primaryshade1,
            child: Column(
              children: [
                AppSize.statusBarHeight(context),
                const SizedBox(height: AppSize.s20),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppPadding.p20,
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p25),
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
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: AppPadding.p4,
                                  ),
                                  child: InkWell(
                                    child: SvgPicture.asset(IconsAssets.menu),
                                  ),
                                ),
                                Container(),
                              ],
                            ),
                            Center(
                              child: Text(
                                AppStrings.drawerActivityLog,
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
                      ],
                    ),
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
                  width: getScreenWidth(context) * 0.8,
                  child: _getSearchTextField(context),
                ),
                InkWell(
                  child: SvgPicture.asset(
                    IconsAssets.filter,
                    width: AppSize.s18,
                    height: AppSize.s18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s15),
          Expanded(
            child: _getActivityLogsList(),
          ),
        ],
      ),
    );
  }

  _getSearchTextField(context) {
    return Stack(
      children: [
        TextFormField(
          enabled: false,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.whiteNeutral,
              ),
          decoration: InputDecoration(
            hintText: AppStrings.usersSearchusers,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.greyNeutral3,
                ),
            fillColor: ColorManager.greyshade1,
            prefixIcon: Transform.scale(
              scale: 0.35,
              child: SvgPicture.asset(
                IconsAssets.search,
                fit: BoxFit.cover,
                theme: const SvgTheme(
                  currentColor: ColorManager.greyNeutral3,
                ),
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getActivityLogsList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
          _singleActivityLog(),
        ],
      ),
    );
  }

  Widget _singleActivityLog() {
    return const SingleActivityLog(isShimmer: true);
  }


}
