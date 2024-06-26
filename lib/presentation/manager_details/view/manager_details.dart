import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/shared_widgets/custom_switch.dart';

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
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/manager_details/viewmodel/manager_details_viewmodel.dart';
import 'package:intl/intl.dart' as intl;

class ManagerDetailsView extends StatefulWidget {
  const ManagerDetailsView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManagerDetailsViewState createState() => _ManagerDetailsViewState();
}

class _ManagerDetailsViewState extends State<ManagerDetailsView> {
  final ManagerDetailsViewModel _viewModel =
      instance<ManagerDetailsViewModel>();
  ManagerOverviewApi? managerOverviewApiVar;

  TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  _bind() {
    _viewModel.start();
    _viewModel.outputManagerOverviewApi.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => managerOverviewApiVar = event);
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
                await _viewModel.getManagerDataStreamingly();
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
              const SizedBox(height: 12),
              // AppSize.statusBarHeight(context),
              Container(
                margin: const EdgeInsets.only(
                  bottom: AppMargin.m20,
                ),
                child: _getAppBarWithActions(context),
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

  AppBar _getAppBarWithActions(context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          IconsAssets.back,
          height: 16,
          width: 16,
        ),
        onPressed: () => Nav.popRoute(context),
      ),
      title: Text(
        AppStrings.managerOverviewTitle,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
            ),
      ),
      actions: [
        PopupMenuButton<SingleManagerAction>(
          onSelected: (SingleManagerAction choice) =>
              _openActions(choice, context),
          color: ColorManager.whiteNeutral,
          elevation: Constants.zeroDouble,
          icon: SvgPicture.asset(
            IconsAssets.actions,
            height: 16,
            width: 16,
            theme: const SvgTheme(
              currentColor: ColorManager.whiteNeutral,
            ),
            // ignore: deprecated_member_use
            color: ColorManager.whiteNeutral,
          ),
          enabled: Constants.trueBool,
          surfaceTintColor: ColorManager.primaryshade3,
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p10,
            horizontal: AppPadding.p20,
          ),
          splashRadius: AppSize.s20,
          position: PopupMenuPosition.over,
          shape: RoundedRectangleBorder(
            borderRadius: RadiusSizes.radius4,
            side: BorderSide(
              color: ColorManager.greyNeutral.withOpacity(0.25),
              width: AppSize.s1,
            ),
          ),
          itemBuilder: (BuildContext context) {
            return _viewModel.managerActions.map(
              (SingleManagerAction choice) {
                return PopupMenuItem<SingleManagerAction>(
                  value: choice,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p5,
                    horizontal: AppPadding.p10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: AppMargin.m10),
                        child: SvgPicture.asset(
                          choice.icon!,
                          height: AppSize.s18,
                          width: AppSize.s18,
                          // ignore: deprecated_member_use
                          color: ColorManager.blackNeutral,
                        ),
                      ),
                      Text(
                        choice.text!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorManager.blackNeutral,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ).toList();
          },
        ),
      ],
    );
  }

  _getManagerDetailsContent() {
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
            SingleListTile(
              list: _viewModel.listOfManagerInforms(managerOverviewApiVar),
            ),
          ],
        ),
      ),
    );
  }

  void _openActions(SingleManagerAction selectedAction, context) async {
    switch (selectedAction.text) {
      case AppStrings.managerActionDelete:
        _makeDeleteAction(context);
        break;
      case AppStrings.managerActionRename:
        _makeRenameAction(context);
        break;
      case AppStrings.managerActionDeposit:
        _makeDepositAction(context);
        break;
      case AppStrings.managerActionWithdrawal:
        _makeWithdrawalAction(context);
        break;
      case AppStrings.managerActionEdit:
        Nav.navTo(context, Routes.editManagerRoute);
        break;
    }
  }

  void _makeRenameAction(context) {
    _newUsernameController = TextEditingController(
      text: managerOverviewApiVar?.data?.username,
    );
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getRenameUsernameDialogContent(),
        AppStrings.userActionRename,
        AppStrings.managerActionRenameDialogTitle,
        IconsAssets.checkUserAction,
        () {
          if (_newUsernameController.text.isNotEmpty) {
            FocusScope.of(context).unfocus();
            Nav.popRoute(context);
            _viewModel.renameUsername(_newUsernameController.text);
          }
        },
      ),
    );
  }

  Widget _getRenameUsernameDialogContent() {
    return getActionTextFieldInput(
      "",
      context,
      _newUsernameController,
      (val) {
        FocusScope.of(context).unfocus();
        if (val.isNotEmpty) {
          Nav.popRoute(context);
          _viewModel.renameUsername(_newUsernameController.text);
          _newUsernameController.clear();
        }
      },
      AppStrings.usernameInputtitle,
      Constants.trueBool,
    );
  }

  void _makeDeleteAction(context) {
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getDeleteDialogContent(),
        AppStrings.userActionDelete,
        AppStrings.managerActionDeleteDialogTitle,
        IconsAssets.trashUserAction,
        () {
          Nav.popRoute(context);
          _viewModel.deleteManager(context);
        },
      ),
    );
  }

  Widget _getDeleteDialogContent() {
    return Text(
      "${AppStrings.actionDeleteManagerdialogTitle} ${managerOverviewApiVar?.data?.username}?",
       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorManager.blackNeutral,
          ),
    );
  }

  void _makeDepositAction(context) {
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getDepositDialogContent(),
        AppStrings.userActionDeposit,
        AppStrings.depositAmountInputDialogtitle,
        IconsAssets.arrowrightUserAction,
        () {
          if (_amountController.text.isNotEmpty) {
            FocusScope.of(context).unfocus();
            Nav.popRoute(context);
            _viewModel.depositAction(
              _amountController.text,
              _commentController.text,
              isChecked,
            );
            _amountController.clear();
            _commentController.clear();
          }
        },
      ),
    );
  }

  bool isChecked = Constants.falseBool;

  Widget _getDepositDialogContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _balanceLabel(
          (managerOverviewApiVar?.data?.username)!,
          (managerOverviewApiVar?.data?.balance?.toDouble())!,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: getActionTextFieldInput(
            "0",
            context,
            _amountController,
            (val) {},
            AppStrings.amountInputtitle,
            Constants.trueBool,
            TextInputType.number,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.loanSwitch,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorManager.blackNeutral,
                    ),
              ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return CustomSwitch(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
        _balanceLabel(
          (_viewModel.upperUsername)!,
          (_viewModel.upperBalance?.toDouble())!,
        ),
        getActionTextFieldInput(
          "Add you comment",
          context,
          _commentController,
          (val) {},
          AppStrings.commentInputtitle,
          Constants.falseBool,
        ),
      ],
    );
  }

  Widget _balanceLabel(String username, double balance) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppMargin.m25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m5),
            child: Text(
              AppStrings.managerDepositBalanceUsernameString(username),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorManager.blackNeutral,
                  ),
            ),
          ),
          Text(
            "${_viewModel.dataCaptcha?.data?.siteCurrency} ${intl.NumberFormat.decimalPattern().format(balance)}",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: ColorManager.greyNeutral5,
                ),
          ),
        ],
      ),
    );
  }

  void _makeWithdrawalAction(context) {
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getWithdrawDialogContent(),
        AppStrings.userActionWithdrawal,
        AppStrings.deductAmountInputDialogtitle,
        IconsAssets.arrowleftUserAction,
        () {
          if (_amountController.text.isNotEmpty) {
            FocusScope.of(context).unfocus();
            Nav.popRoute(context);
            _viewModel.withdrawAction(
              _amountController.text,
              _commentController.text,
            );
            _amountController.clear();
            _commentController.clear();
          }
        },
      ),
    );
  }

  Widget _getWithdrawDialogContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _balanceLabel(
          (managerOverviewApiVar?.data?.username)!,
          (managerOverviewApiVar?.data?.balance?.toDouble())!,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: getActionTextFieldInput(
            "0",
            context,
            _amountController,
            (val) {},
            AppStrings.amountInputtitle,
            Constants.trueBool,
            TextInputType.number,
          ),
        ),
        getActionTextFieldInput(
          "Add you comment",
          context,
          _commentController,
          (val) {},
          AppStrings.commentInputtitle,
          Constants.falseBool,
        )
      ],
    );
  }
}
