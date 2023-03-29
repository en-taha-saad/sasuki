import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/text_shimmer.dart';

class SingleCardStatistics extends StatelessWidget {
  const SingleCardStatistics({
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
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.s15,
        horizontal: AppSize.s20,
      ),
      height: AppSize.s72,
      decoration: BoxDecoration(
        color: ColorManager.primaryshade1,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          singleCardStatisticsInform(
            context,
            totalUsers,
            AppStrings.totalUsers,
          ),
          singleCardStatisticsInform(
            context,
            activeUsers,
            AppStrings.activeUsers,
          ),
          singleCardStatisticsInform(
            context,
            expiredUsers,
            AppStrings.expiredUsers,
          ),
          singleCardStatisticsInform(
            context,
            onlineUsers,
            AppStrings.onlineUsers,
          ),
        ],
      ),
    );
  }

  Widget singleCardStatisticsInform(
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
        Text(
          label!,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
