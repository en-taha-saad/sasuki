import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
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
    return Card(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p15),
        height: AppSize.s144,
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
                color: ColorManager.whiteNeutral,
              ),
            ),
            const SizedBox(width: AppSize.s15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          username!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: getScreenWidth(context) * AppSize.s0point25,
                    ),
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
                const SizedBox(height: AppSize.s10),
                Container(
                  width: getScreenWidth(context) * AppSize.s0point6,
                  decoration: BoxDecoration(
                    color: ColorManager.transparent,
                    borderRadius: RadiusSizes.radius15,
                    border: Border.all(
                      color: ColorManager.primaryshade1,
                      width: AppSize.s1,
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
                Text(
                  "Expires on $expireOn",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorManager.greyNeutral,
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
      ),
    );
  }
}
