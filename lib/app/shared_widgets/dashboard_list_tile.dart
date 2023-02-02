import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class DashboardListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? trailing;
  const DashboardListTile({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSize.s25,
          ),
          child: const Divider(),
        ),
        ListTile(
          title: Text(
            title!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subtitle: Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.greyNeutral,
                ),
          ),
          trailing: Text(
            trailing.toString(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
