import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class SingleCardStatistics extends StatelessWidget {
  const SingleCardStatistics({
    this.totalUsers,
    this.activeUsers,
    this.expiredUsers,
    this.onlineUsers,
    super.key,
  });
  final String? totalUsers;
  final String? activeUsers;
  final String? expiredUsers;
  final String? onlineUsers;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s15),
      margin: const EdgeInsets.symmetric(horizontal: AppSize.s25),
      height: AppSize.s80,
      decoration: BoxDecoration(
        color: ColorManager.primaryshade1,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Row(
        children: [
          singleCardStatisticsInform(
            context,
            totalUsers,
            AppStrings.totalUsers,
          ),
          const SizedBox(width: AppSize.s25),
          singleCardStatisticsInform(
            context,
            activeUsers,
            AppStrings.activeUsers,
          ),
          const SizedBox(width: AppSize.s25),
          singleCardStatisticsInform(
            context,
            expiredUsers,
            AppStrings.expiredUsers,
          ),
          const SizedBox(width: AppSize.s25),
          singleCardStatisticsInform(
            context,
            onlineUsers,
            AppStrings.onlineUsers,
          ),
        ],
      ),
    );
  }

  Column singleCardStatisticsInform(
    context,
    String? value,
    String? label,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          label!,
          style: StylesManager.getMediumStyle(
            color: ColorManager.semiWhiteNeutral,
            fontSize: FontSize.sSubtitle5,
          ),
        ),
      ],
    );
  }
}
