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
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/card_title.dart';
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
        // TODO: implement timer
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
                margin: const EdgeInsets.only(
                  right: AppMargin.m25,
                  left: AppMargin.m25,
                  top: AppMargin.m20,
                  bottom: AppMargin.m25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: AppSize.s12,
                            ),
                            child: SvgPicture.asset(IconsAssets.menu),
                          ),
                          onTap: () {
                            Nav.navTo(context, Routes.drawerRoute);
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            _viewModel.selectedServer?.name ??
                                Constants.emptyStr,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    Text(
                      AppStrings.welcome,
                      style: StylesManager.getRegularStyle(
                        color: ColorManager.greyNeutral3,
                        fontSize: FontSize.sSubtitle2,
                        height: AppSize.s1_5,
                      ),
                    ),
                    StreamBuilder<Auth>(
                      stream: _viewModel.outputAuthData,
                      builder: (context, snapshot) {
                        return Text(
                          "${snapshot.data?.client?.firstname ?? Constants.dash} ${snapshot.data?.client?.lastname ?? Constants.dash}",
                          style: StylesManager.getMediumStyle(
                            color: ColorManager.whiteNeutral,
                            fontSize: FontSize.sHeading5,
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
                              style: StylesManager.getMediumStyle(
                                color: ColorManager.whiteNeutral,
                                fontSize: FontSize.sHeading5,
                                height: AppSize.s1_5,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Text(
                      AppStrings.availableBalance,
                      style: StylesManager.getRegularStyle(
                        color: ColorManager.greyNeutral3,
                        fontSize: FontSize.sSubtitle2,
                        height: AppSize.s1_5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorManager.secondary,
            child: _getDashboardContent(),
          ),
        ),
      ],
    );
  }

  _getDashboardContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getCardTitle(
            IconsAssets.dashboardUserStatistics,
            AppStrings.dashboardUsersStatistics,
            context,
          ),
          StreamBuilder<Dashboard>(
            stream: _viewModel.outputDashboardData,
            builder: (context, snapshot) {
              return DashboardListTile(
                list: _viewModel.listOfUserStatistics(snapshot.data),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: AppSize.s20),
            child: getCardTitle(
              IconsAssets.dashboardSalesAndFinance,
              AppStrings.dashboardSalesFinance,
              context,
            ),
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
}
