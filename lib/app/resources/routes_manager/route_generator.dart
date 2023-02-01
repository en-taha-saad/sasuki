import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.drawerRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: Center(
              child: Text(
                Routes.drawerRoute,
              ),
            ),
          ),
          settings: settings,
        );
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: Center(
              child: ItemCard(),
            ),
          ),
          settings: settings,
        );
      // TODO add your routes here
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const AppBackground(
        child: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String? status;
  final String? profileName;
  final String? fullName;
  final String? username;
  final String? balance;
  final Color? statusColor;
  const ItemCard({
    this.status = "active",
    this.profileName = "group",
    this.username = "taha_saad",
    this.fullName = "Taha Saad",
    this.balance = "IQD 25,000",
    this.statusColor = ColorManager.greenAnnotations,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p15),
        child: SizedBox(
          height: AppSize.s144,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Container(
                margin: const EdgeInsets.only(right: AppMargin.m15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(height: AppSize.s24),
                            ),
                            Text(
                              username!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(height: AppSize.s18),
                            ),
                          ],
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
                    const Divider(
                      color: ColorManager.whiteNeutral,
                      thickness: AppSize.s2,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
