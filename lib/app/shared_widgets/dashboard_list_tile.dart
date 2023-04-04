import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';

class DashboardListTile extends StatelessWidget {
  final List<CardElement>? list;
  final Widget? shimmerText;
  const DashboardListTile({
    super.key,
    this.list,
    this.shimmerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m25),
      child: Column(
        children: list!
            .map(
              (e) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            e.subtitle,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorManager.greyNeutral,
                                    ),
                            softWrap: Constants.trueBool,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      shimmerText != Constants.nullValue
                          ? shimmerText ?? Container()
                          : Text(
                              e.number,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                    ],
                  ),
                  if (e != list?.last)
                    Column(
                      children: [
                        Divider(
                          color: ColorManager.greyNeutral.withOpacity(
                            AppSize.s0point25,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
