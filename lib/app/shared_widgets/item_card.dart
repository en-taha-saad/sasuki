import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';

class ItemCard extends StatelessWidget {
  final String? status;
  final String? profileName;
  final String? fullName;
  final String? expireOn;
  final String? username;
  final String? balance;
  final Color? statusColor;
  const ItemCard({
    this.status = "active",
    this.profileName = "group",
    this.username = "taha_saad",
    this.fullName = "Taha Saad",
    this.balance = "IQD 25,000",
    this.expireOn = "2021-09-09",
    this.statusColor = ColorManager.greenAnnotations,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primaryshade3,
        borderRadius: RadiusSizes.radius12,
      ),
      margin: const EdgeInsets.only(
        right: AppMargin.m25,
        left: AppMargin.m25,
        bottom: AppMargin.m10,
      ),
      padding: const EdgeInsets.all(AppPadding.p15),
      child: Row(
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
              height: AppSize.s24,
              width: AppSize.s24,
              theme: const SvgTheme(
                currentColor: ColorManager.whiteNeutral,
              ),
            ),
          ),
          const SizedBox(width: AppSize.s15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppSize.s150,
                    child: Text(
                      fullName!,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: Constants.oneNum.toInt(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: Constants.trueBool,
                    ),
                  ),
                  SizedBox(width: getScreenWidth(context) * 0.05),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p15,
                      vertical: AppPadding.p3Point5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: RadiusSizes.radius15,
                    ),
                    child: Text(
                      status!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: AppSize.s150,
                child: Text(
                  username!,
                  style: Theme.of(context).textTheme.bodySmall,
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
                    color: ColorManager.primaryshade1,
                    width: AppSize.s0point6,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s10),
              Text(
                balance!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorManager.greyNeutral,
                    ),
              ),
              const SizedBox(height: AppSize.s10),
              SizedBox(
                width: AppSize.s210,
                child: Text(
                  "Expires on $expireOn",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
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
                    color: ColorManager.primaryshade1,
                    width: AppSize.s1,
                  ),
                ),
                child: Text(
                  profileName!,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
