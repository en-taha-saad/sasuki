import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/dashboard_list_tile.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:intl/intl.dart' as intl;

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardViewModel _viewModel = instance<DashboardViewModel>();
  Timer? timer;
  _bind() {
    _viewModel.start();
    _viewModel.outputDashboardData.listen(
      (event) {
        if (_viewModel.gotInforms == false) {
          _viewModel.getDataStreamingly();
        }
      },
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: Constants.delay60Seconds),
      (Timer t) {
        // ignore: todo
        // TODO: add logic to refresh data
        // _viewModel.getDataStreamingly();
      },
    );

    _bind();
    super.initState();
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
                _getScreenView(),
                () async {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  await _viewModel.getDataStreamingly();
                },
              ) ??
              _getScreenView();
        },
      ),
    );
  }

  Widget _getScreenView() {
    return RefreshIndicator(
      onRefresh: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        await _viewModel.getDataStreamingly();
      },
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      backgroundColor: ColorManager.whiteNeutral,
      color: ColorManager.backgroundCenter,
      child: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppSize.statusBarHeight(context),
          const SizedBox(height: AppSize.s20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: SvgPicture.asset(IconsAssets.menu),
                      onTap: () {
                        Nav.navTo(context, Routes.drawerRoute);
                      },
                    ),
                    Text(
                      _viewModel.selectedServer?.name ?? Constants.emptyStr,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Container(),
                  ],
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
                StreamBuilder<Auth>(
                  stream: _viewModel.outputAuthData,
                  builder: (context, snapshot) {
                    return Text(
                      "${snapshot.data?.client?.firstname ?? Constants.dash} ${snapshot.data?.client?.lastname ?? Constants.dash}",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: ColorManager.whiteNeutral,
                                height: AppSize.s1_5,
                              ),
                    );
                  },
                ),
                StreamBuilder<Dashboard>(
                  stream: _viewModel.outputDashboardData,
                  builder: (context, snapshot) {
                    final balance = snapshot.data?.data?.balance;
                    return StreamBuilder<Captcha>(
                      stream: _viewModel.outputDataCaptcha,
                      builder: (context, snapshot) {
                        final currency = snapshot.data?.data?.siteCurrency;
                        return Text(
                          "${currency ?? Constants.dash} ${balance != Constants.nullValue ? intl.NumberFormat.decimalPattern().format(balance) : Constants.dash}",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: ColorManager.whiteNeutral
                                    .withOpacity(AppSize.s0_5),
                                height: AppSize.s1_5,
                              ),
                        );
                      },
                    );
                  },
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
          const SizedBox(height: AppSize.s25),
          Container(
            width: MediaQuery.of(context).size.width,
            child: _getDashboardContent(),
            decoration: const BoxDecoration(
              color: ColorManager.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s35),
                topRight: Radius.circular(AppSize.s35),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getDashboardContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _getCardTitle(
            IconsAssets.dashboardUserStatistics,
            AppStrings.dashboardUsersStatistics,
          ),
          StreamBuilder<Dashboard>(
            stream: _viewModel.outputDashboardData,
            builder: (context, snapshot) {
              return DashboardListTile(
                list: _viewModel.listOfUserStatistics(snapshot.data),
              );
            },
          ),
          _getCardTitle(
            IconsAssets.dashboardSalesAndFinance,
            AppStrings.dashboardSalesFinance,
          ),
          StreamBuilder<Dashboard>(
            stream: _viewModel.outputDashboardData,
            builder: (context, snapshot) {
              return DashboardListTile(
                list: _viewModel.listOfSalesAndFinance(snapshot.data),
              );
            },
          ),
          const SizedBox(height: AppSize.s50),
        ],
      ),
    );
  }

  Widget _getCardTitle(icon, title) {
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
}
