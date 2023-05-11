import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_choose_server_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_login_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/shared_widgets/expandable_reports.dart';
import 'package:sasuki/domain/models/drawer/drawer_single_bar.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

// ignore: must_be_immutable
class DrawerView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var currentRoute;

  DrawerView(this.currentRoute, {super.key});

  final AppPreferences _appPrefs = instance<AppPreferences>();

  final DashboardViewModel _viewModel = instance<DashboardViewModel>();

  List<DrawerSingleBar> listOfDrawerBars = [];

  List<DrawerSingleBar> getListOfDrawerItems() {
    listOfDrawerBars.add(
      DrawerSingleBar(
        AppStrings.drawerDashboard,
        IconsAssets.dashboard,
      ),
    );

    if ((_viewModel.auth?.permissions.contains("prm_users_index"))!) {
      listOfDrawerBars.add(
        DrawerSingleBar(
          AppStrings.drawerUsersList,
          IconsAssets.usersList,
        ),
      );
    }
    if ((_viewModel.auth?.permissions.contains("prm_managers_index"))!) {
      listOfDrawerBars.add(
        DrawerSingleBar(
          AppStrings.drawerManagers,
          IconsAssets.managers,
        ),
      );
    }
    if ((_viewModel.auth?.permissions
            .contains("prm_report_managers_invoices"))! ||
        (_viewModel.auth?.permissions
            .contains("prm_report_managers_journal"))! ||
        (_viewModel.auth?.permissions.contains("prm_report_activations"))!) {
      listOfDrawerBars.add(
        DrawerSingleBar(
          AppStrings.drawerReports,
          IconsAssets.reports,
        ),
      );
    }
    if ((_viewModel.auth?.permissions.contains("prm_report_syslog"))!) {
      listOfDrawerBars.add(
        DrawerSingleBar(
          AppStrings.drawerActivityLog,
          IconsAssets.activityLog,
        ),
      );
    }
    // if ((_viewModel.auth?.permissions.contains("prm_managers_deposit"))!) {
    //   DrawerSingleBar(
    //     AppStrings.drawerDepositButton,
    //     IconsAssets.deposit,
    //   );
    // }
    listOfDrawerBars.add(
      DrawerSingleBar(
        AppStrings.drawerLogout,
        IconsAssets.logout,
      ),
    );
    return listOfDrawerBars;
  }

  _manageDrawerNavigations(String newRouteName, BuildContext context) {
    if (newRouteName == currentRoute) {
      Nav.popRoute(context);
    } else {
      Nav.replaceTo(context, newRouteName);
    }
  }

  void Function()? onDrawerBarTapped(
    DrawerSingleBar drawerSingleBar,
    BuildContext context,
  ) {
    return () {
      switch (drawerSingleBar.title) {
        case AppStrings.drawerDashboard:
          _manageDrawerNavigations(Routes.dashboardRoute, context);
          break;
        case AppStrings.drawerUsersList:
          _manageDrawerNavigations(Routes.usersListRoute, context);
          break;
        case AppStrings.drawerManagers:
          _manageDrawerNavigations(Routes.managersListRoute, context);
          break;
        case AppStrings.drawerActivityLog:
          _manageDrawerNavigations(Routes.activityLogsRoute, context);
          break;
        // case AppStrings.drawerDepositButton:
        //   _manageDrawerNavigations(Routes.depositPaymentRoute, context);
        //   break;
        case AppStrings.drawerLogout:
          _appPrefs.removeIsUserLoggedInStatus();
          _appPrefs.removeToken();
          initChooseServerModule();
          initLoginModule();
          Nav.replaceTo(context, Routes.loginRoute);
          break;
      }
    };
  }

  List<SingleReport> listOfReports = [];

  getListOfReports(context) {
    if ((_viewModel.auth?.permissions.contains("prm_report_activations"))!) {
      listOfReports.add(
        SingleReport(
          title: AppStrings.drawerReportsActivations,
          action: () {
            _manageDrawerNavigations(
              Routes.reportsActivationsRoute,
              context,
            );
          },
        ),
      );
    }

    if ((_viewModel.auth?.permissions
        .contains("prm_report_managers_invoices"))!) {
      listOfReports.add(
        SingleReport(
          title: AppStrings.drawerReportsInvoices,
          action: () {
            _manageDrawerNavigations(
              Routes.reportsInvoicesRoute,
              context,
            );
          },
        ),
      );
    }

    if ((_viewModel.auth?.permissions
        .contains("prm_report_managers_journal"))!) {
      listOfReports.add(
        SingleReport(
          title: AppStrings.drawerReportsJournal,
          action: () {
            _manageDrawerNavigations(
              Routes.reportsJournalRoute,
              context,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    listOfReports = [];
    listOfDrawerBars = [];
    getListOfDrawerItems();
    getListOfReports(context);
    return _getContentWidget(context);
  }

  Widget _getContentWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: ColorManager.primaryshade1,
          child: Column(
            children: [
              AppSize.statusBarHeight(context),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: AppPadding.p5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: SvgPicture.asset(IconsAssets.cancel),
                          onTap: () => Nav.popRoute(context),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          _viewModel.selectedServer?.name ?? Constants.emptyStr,
                          softWrap: true,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    Text(
                      AppStrings.welcome,
                      style: StylesManager.getRegularStyle(
                        color: ColorManager.greyNeutral3,
                        fontSize: FontSize.sSubtitle5,
                        height: AppSize.s1_5,
                      ),
                    ),
                    Text(
                      "${_viewModel.auth?.client?.firstname ?? Constants.emptyStr} ${_viewModel.auth?.client?.lastname ?? Constants.emptyStr}",
                      style: StylesManager.getMediumStyle(
                        color: ColorManager.whiteNeutral,
                        fontSize: FontSize.sHeading4,
                        height: AppSize.s1_5,
                      ),
                    ),
                    Text(
                      "${_viewModel.dataCaptcha?.data?.siteCurrency ?? Constants.emptyStr} ${_viewModel.dashboardData?.data?.balance != Constants.nullValue ? intl.NumberFormat.decimalPattern().format(_viewModel.dashboardData?.data?.balance) : Constants.emptyStr}",
                      style: StylesManager.getMediumStyle(
                        color: ColorManager.whiteNeutral,
                        fontSize: FontSize.sHeading4,
                        height: AppSize.s1_5,
                      ),
                    ),
                    Text(
                      AppStrings.availableBalance,
                      style: StylesManager.getRegularStyle(
                        color: ColorManager.greyNeutral3,
                        fontSize: FontSize.sSubtitle5,
                        height: AppSize.s1_5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s25),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _getDrawerContent(context),
            decoration: const BoxDecoration(color: ColorManager.secondary),
          ),
        ),
      ],
    );
  }

  _getDrawerContent(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: listOfDrawerBars
            .map(
              (element) => InkWell(
                onTap: onDrawerBarTapped(element, context),
                child: Column(
                  children: [
                    if (element == listOfDrawerBars.first)
                      const SizedBox(height: AppSize.s25),
                    Container(
                      margin: ((listOfDrawerBars.indexOf(element) ==
                                      AppSize.s2 &&
                                  element.title == AppStrings.drawerManagers) ||
                              (listOfDrawerBars.indexOf(element) ==
                                      AppSize.s4 &&
                                  element.title ==
                                      AppStrings.drawerActivityLog))
                          ? null
                          : listOfDrawerBars.indexOf(element) == AppSize.s3
                              ? const EdgeInsets.only(bottom: AppSize.s10)
                              : const EdgeInsets.only(bottom: AppSize.s20),
                      child: element.title != AppStrings.drawerReports
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    element.icon!,
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: AppSize.s20),
                                  Text(
                                    element.title,
                                    style: StylesManager.getRegularStyle(
                                      color: ColorManager.whiteNeutral,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ExpandableReports(
                              title: element.title,
                              listOfReports: listOfReports,
                            ),
                    ),
                    if ((listOfDrawerBars.indexOf(element) ==
                        AppSize.s2 &&
                        element.title == AppStrings.drawerManagers) ||
                        (listOfDrawerBars.indexOf(element) ==
                            AppSize.s4 &&
                            element.title ==
                                AppStrings.drawerActivityLog))
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p25),
                        child: Divider(
                          color: ColorManager.greyNeutral.withOpacity(
                            AppSize.s0point25,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
