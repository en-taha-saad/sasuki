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
import 'package:sasuki/domain/models/drawer/drawer_single_bar.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';

// ignore: must_be_immutable
class DrawerView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var currentRoute;

  DrawerView(this.currentRoute, {super.key});
  final AppPreferences _appPrefs = instance<AppPreferences>();

  final DashboardViewModel _viewModel = instance<DashboardViewModel>();
  List<DrawerSingleBar> listOfDrawerBars = [
    ///
    DrawerSingleBar(
      AppStrings.drawerDashboard,
      IconsAssets.dashboard,
    ),
    DrawerSingleBar(
      AppStrings.drawerUsersList,
      IconsAssets.usersList,
    ),
    DrawerSingleBar(
      AppStrings.drawerOnlineUsers,
      IconsAssets.reports,
    ),
    DrawerSingleBar(
      AppStrings.drawerManagers,
      IconsAssets.managers,
    ),

    ///
    DrawerSingleBar(
      AppStrings.drawerReports,
      IconsAssets.reports,
    ),
    DrawerSingleBar(
      AppStrings.drawerActivityLog,
      IconsAssets.activityLog,
    ),

    ///
    DrawerSingleBar(
      AppStrings.drawerDepositButton,
      IconsAssets.deposit,
    ),
    DrawerSingleBar(
      AppStrings.drawerLogout,
      IconsAssets.logout,
    ),
  ];

  List<DrawerSingleBar> listOfDrawer() {
    for (String permission in (_viewModel.auth?.permissions)!) {
      if (permission == AppStrings.admin) {
        listOfDrawerBars.add(
          DrawerSingleBar(
            AppStrings.drawerDashboard,
            IconsAssets.dashboard,
          ),
        );
      }
    }
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
        // TODO add screen
        // case AppStrings.drawerUsersList:
        //   _manageDrawerNavigations(Routes.usersListRoute, context);
        //   break;
        // case AppStrings.drawerManagers:
        //   _manageDrawerNavigations(Routes.managersListRoute, context);
        //   break;
        // case AppStrings.drawerReports:
        //   _manageDrawerNavigations(AppStrings.drawerReports, context);
        //   break;
        // case AppStrings.drawerActivityLog:
        //   _manageDrawerNavigations(AppStrings.drawerActivityLog, context);
        //   break;
        // case AppStrings.drawerDepositButton:
        //   _manageDrawerNavigations(AppStrings.drawerDepositButton, context);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Constants.falseBool,
      child: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, AsyncSnapshot<FlowState> snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getScreenView(context),
                () async {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  await _viewModel.getDataStreamingly();
                },
              ) ??
              _getScreenView(context);
        },
      ),
    );
  }

  Widget _getScreenView(context) {
    return RefreshIndicator(
      onRefresh: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        await _viewModel.getDataStreamingly();
      },
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      backgroundColor: ColorManager.whiteNeutral,
      color: ColorManager.backgroundCenter,
      child: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppSize.statusBarHeight(context),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: SvgPicture.asset(IconsAssets.cancel),
                    onTap: () => Nav.popRoute(context),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    _viewModel.selectedServer?.name ?? Constants.emptyStr,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                Text(
                  AppStrings.welcome,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                            ColorManager.whiteNeutral.withOpacity(AppSize.s0_5),
                        height: AppSize.s1_5,
                      ),
                ),
                Text(
                  "${_viewModel.auth?.client?.firstname ?? Constants.emptyStr} ${_viewModel.auth?.client?.lastname ?? Constants.emptyStr}",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: ColorManager.whiteNeutral,
                        height: AppSize.s1_5,
                      ),
                ),
                Text(
                  "${_viewModel.dataCaptcha?.data?.siteCurrency ?? Constants.emptyStr} ${_viewModel.dashboardData?.data?.balance != Constants.nullValue ? intl.NumberFormat.decimalPattern().format(_viewModel.dashboardData?.data?.balance) : Constants.emptyStr}",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color:
                            ColorManager.whiteNeutral.withOpacity(AppSize.s0_5),
                        height: AppSize.s1_5,
                      ),
                ),
                Text(
                  AppStrings.availableBalance,
                  style: StylesManager.getMediumStyle(
                    color: ColorManager.whiteNeutral.withOpacity(
                      AppSize.s0_5,
                    ),
                    height: AppSize.s1_5,
                    fontSize: FontSize.sSubtitle5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s35),
          Container(
            width: MediaQuery.of(context).size.width,
            child: _getDrawerContent(context),
            decoration: const BoxDecoration(color: ColorManager.secondary),
          ),
        ],
      ),
    );
  }

  _getDrawerContent(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
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
                      const SizedBox(height: AppSize.s50),
                    Container(
                      margin: const EdgeInsets.only(bottom: AppSize.s20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(element.icon!),
                          const SizedBox(width: AppSize.s20),
                          Text(
                            element.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    if (listOfDrawerBars.indexOf(element) == AppSize.s3 ||
                        listOfDrawerBars.indexOf(element) == AppSize.s5)
                      Container(
                        margin: const EdgeInsets.only(bottom: AppSize.s20),
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
