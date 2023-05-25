import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/text_shimmer.dart';

class SingleUserCard extends StatelessWidget {
  final String? status;
  final String? profileName;
  final String? fullName;
  final String? expireOn;
  final String? username;
  final String? balance;
  final Color? statusColor;
  final bool? isShimmer;
  final bool? isOnline;
  const SingleUserCard({
    this.status = "active",
    this.profileName = "group",
    this.username = "taha_saad",
    this.fullName = "Taha Saad",
    this.balance = "IQD 25,000",
    this.expireOn = "2021-09-09",
    this.isOnline,
    this.statusColor = ColorManager.greenAnnotations,
    this.isShimmer,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff324677),
        borderRadius: RadiusSizes.radius12,
      ),
      margin: const EdgeInsets.only(
        right: AppMargin.m25,
        left: AppMargin.m25,
        bottom: AppMargin.m10,
      ),
      padding: const EdgeInsets.all(AppPadding.p15),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                  color: ColorManager.secondary,
                  borderRadius: RadiusSizes.radius12,
                ),
                child: SvgPicture.asset(
                  IconsAssets.person,
                  height: AppSize.s20,
                  width: AppSize.s20,
                  theme: const SvgTheme(
                    currentColor: ColorManager.whiteNeutral,
                  ),
                  // ignore: deprecated_member_use
                  color: ColorManager.whiteNeutral,
                ),
              ),
              const SizedBox(width: AppSize.s15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isShimmer != Constants.nullValue &&
                          isShimmer != Constants.falseBool
                      ? const ShimmerText(
                          baseColor: ColorManager.whiteNeutral,
                          highlightColor: ColorManager.backgroundCenter,
                          width: AppSize.s50,
                        )
                      : SizedBox(
                          width: AppSize.s150,
                          child: Text(
                            fullName!,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: Constants.oneNum.toInt(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: Constants.trueBool,
                          ),
                        ),
                  SizedBox(
                    width: AppSize.s150,
                    child: isShimmer != Constants.nullValue &&
                            isShimmer != Constants.falseBool
                        ? const ShimmerText(
                            baseColor: ColorManager.whiteNeutral,
                            highlightColor: ColorManager.backgroundCenter,
                            width: AppSize.s30,
                          )
                        : Text(
                            username!,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                            maxLines: Constants.oneNum.toInt(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: Constants.trueBool,
                          ),
                  ),
                  const SizedBox(height: AppSize.s10),
                  Container(
                    width: getScreenWidth(context) * AppSize.s0point6,
                    decoration: BoxDecoration(
                      color: ColorManager.transparent,
                      borderRadius: RadiusSizes.radius15,
                      border: Border.all(
                        color: ColorManager.greyNeutral.withOpacity(0.25),
                        width: AppSize.s0point6,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                    width: AppSize.s210,
                    child: isShimmer != Constants.nullValue &&
                            isShimmer != Constants.falseBool
                        ? const ShimmerText(
                            baseColor: ColorManager.whiteNeutral,
                            highlightColor: ColorManager.backgroundCenter,
                            width: AppSize.s50,
                          )
                        : Text(
                            "Expires on $expireOn",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.greyNeutral,
                                    ),
                            maxLines: Constants.oneNum.toInt(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: Constants.trueBool,
                          ),
                  ),
                  const SizedBox(height: AppSize.s10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p15,
                      vertical: AppPadding.p3,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.transparent,
                      borderRadius: RadiusSizes.radius15,
                      border: Border.all(
                        color: ColorManager.greyNeutral.withOpacity(0.25),
                        width: AppSize.s1,
                      ),
                    ),
                    child: isShimmer != Constants.nullValue &&
                            isShimmer != Constants.falseBool
                        ? const ShimmerText(
                            baseColor: ColorManager.whiteNeutral,
                            highlightColor: ColorManager.backgroundCenter,
                            width: AppSize.s20,
                          )
                        : Text(
                            profileName!,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p15,
                  vertical: AppPadding.p3Point5,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: RadiusSizes.radius15,
                ),
                child: isShimmer != Constants.nullValue &&
                        isShimmer != Constants.falseBool
                    ? const ShimmerText(
                        baseColor: ColorManager.whiteNeutral,
                        highlightColor: ColorManager.backgroundCenter,
                        width: AppSize.s20,
                      )
                    : Text(
                        status!,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: ColorManager.blackNeutral,
                            ),
                      ),
              ),
              const SizedBox(height: 65),
              Container(
                margin: const EdgeInsets.only(right: AppMargin.m8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: AppSize.s8,
                      height: AppSize.s8,
                      margin: const EdgeInsets.only(right: AppSize.s5),
                      decoration: BoxDecoration(
                        color: isOnline != Constants.nullValue &&
                                isOnline != Constants.falseBool
                            ? ColorManager.greenAnnotations2
                            : ColorManager.greyNeutral,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      isOnline != Constants.nullValue &&
                              isOnline != Constants.falseBool
                          ? AppStrings.usersConnectionOnline
                          : AppStrings.usersConnectionOffline,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
