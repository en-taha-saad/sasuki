import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/card_title.dart';
import 'package:sasuki/app/shared_widgets/get_action_dialog_content.dart';
import 'package:sasuki/app/shared_widgets/get_actions_text_field.dart';
import 'package:sasuki/app/shared_widgets/showdialog.dart';
import 'package:sasuki/app/shared_widgets/single_list_tile.dart';
import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/manager_details/viewmodel/manager_details_viewmodel.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sasuki/presentation/reports_activations/viewmodel/reports_activations_viewmodel.dart';

class ReportsActivationsView extends StatefulWidget {
  const ReportsActivationsView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReportsActivationsViewState createState() => _ReportsActivationsViewState();
}

class _ReportsActivationsViewState extends State<ReportsActivationsView> {
  final ReportsActivationsViewModel _viewModel =
      instance<ReportsActivationsViewModel>();
  ActivationsReports? activationsReports;
  _bind() {
    _viewModel.start();
    _viewModel.outputReportsActivations.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => activationsReports = event);
        }
      },
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await _viewModel.getActivationsReportsStreamingly();
              },
            ) ??
            _getScreenView(context);
      },
    );
  }

  Widget _getScreenView(context) {
    return Column(
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
                  bottom: AppMargin.m25,
                ),
                child: _getActivationAppBar(context),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: _getManagerDetailsContent(),
            color: ColorManager.secondary,
          ),
        ),
      ],
    );
  }

  AppBar _getActivationAppBar(context) {
    return AppBar(
      elevation: AppSize.s0,
      backgroundColor: Colors.transparent,
      centerTitle: Constants.trueBool,
      toolbarHeight: 40,
      titleSpacing: 0,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      leading: Container(
        margin: const EdgeInsets.only(
          right: AppMargin.m20,
        ),
        child: IconButton(
          icon: SvgPicture.asset(IconsAssets.back),
          onPressed: () => Nav.popRoute(context),
        ),
      ),
      title: Text(
        AppStrings.drawerReports,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
            ),
      ),
    );
  }

  _getActivationListContent() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          bottom: AppMargin.m50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getCardTitle(
              IconsAssets.information,
              AppStrings.managerOverviewUserInformation,
              context,
            ),
          ],
        ),
      ),
    );
  }
}
