import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';

import 'package:sasuki/app/resources/values_manager/app_size.dart';

Container getEmptyStateWidget(
  BuildContext context,
  void Function()? onPressed,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(ImageAssets.emptyState),
          const SizedBox(height: AppSize.s20),
          Text(
            AppStrings.noUsersFound,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSize.s10),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.refresh,
              size: AppSize.s32,
              color: ColorManager.greyNeutral,
            ),
          ),
        ],
      ),
    ),
  );
}
