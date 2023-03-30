  import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

Widget getCardTitle(icon, title,context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s35),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: AppSize.s15),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: ColorManager.greyNeutral,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Divider(
          color: ColorManager.greyNeutral.withOpacity(
            AppSize.s0point25,
          ),
        ),
        const SizedBox(height: AppSize.s15),
      ],
    );
  }
