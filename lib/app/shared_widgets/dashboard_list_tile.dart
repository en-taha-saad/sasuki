import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';

class DashboardListTile extends StatelessWidget {
  final List<CardElement> list;
  const DashboardListTile({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list
          .map(
            (e) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    e.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    e.subtitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorManager.greyNeutral,
                        ),
                  ),
                  trailing: Text(
                    e.number,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                if (e != list.last)
                  Column(
                    children: [
                      const SizedBox(height: AppSize.s15),
                      Divider(
                        color: ColorManager.greyNeutral.withOpacity(
                          AppSize.s0point25,
                        ),
                      ),
                      const SizedBox(height: AppSize.s15),
                    ],
                  ),
              ],
            ),
          )
          .toList(),
    );
  }
}
