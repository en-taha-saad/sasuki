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
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_status_vals.dart';
import 'package:sasuki/app/shared_widgets/card_title.dart';
import 'package:sasuki/app/shared_widgets/get_action_dialog_content.dart';
import 'package:sasuki/app/shared_widgets/get_actions_text_field.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/showdialog.dart';
import 'package:sasuki/app/shared_widgets/single_list_tile.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final UserDetailsViewModel _viewModel = instance<UserDetailsViewModel>();
  UserOverviewApi? userOverviewApiVar;
  List<ProfileData>? profileList;
  ProfileData? selectedprofile;

  TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  _bind() {
    _viewModel.start();
    _viewModel.outputUserOverviewApi.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => userOverviewApiVar = event);
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
                await _viewModel.getUserDataStreamingly();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getUserActions(context),
                    const SizedBox(height: AppSize.s20),
                    _getStatisticsCard(context),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: _getUserDetailsContent(),
            color: ColorManager.secondary,
          ),
        ),
      ],
    );
  }

  AppBar _getUserActions(context) {
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
        AppStrings.userOverviewTitle,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
            ),
      ),
      actions: [
        PopupMenuButton<SingleUserAction>(
          onSelected: (SingleUserAction choice) =>
              _openActions(choice, context),
          color: ColorManager.whiteNeutral,
          elevation: Constants.zeroDouble,
          icon: Container(
            margin: const EdgeInsets.only(left: AppMargin.m20),
            child: SvgPicture.asset(
              IconsAssets.actions,
              theme: const SvgTheme(
                currentColor: ColorManager.whiteNeutral,
              ),
              // ignore: deprecated_member_use
              color: ColorManager.whiteNeutral,
            ),
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
            borderRadius: RadiusSizes.radius12,
            side: BorderSide(
              color: ColorManager.greyNeutral.withOpacity(0.25),
              width: AppSize.s1,
            ),
          ),
          itemBuilder: (BuildContext context) {
            return _viewModel.userActions.map(
              (SingleUserAction choice) {
                return PopupMenuItem<SingleUserAction>(
                  value: choice,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p5,
                    horizontal: AppPadding.p10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        choice.text!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorManager.blackNeutral,
                            ),
                      ),
                      SvgPicture.asset(
                        choice.icon!,
                        height: AppSize.s18,
                        width: AppSize.s18,
                        // ignore: deprecated_member_use
                        color: ColorManager.blackNeutral,
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

  Widget _getStatisticsCard(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: AppSize.s35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.userOverviewStatus,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: FontSize.sHeading4,
                    ),
              ),
              Row(
                children: [
                  Container(
                    width: AppSize.s8,
                    height: AppSize.s8,
                    margin: const EdgeInsets.only(
                      right: AppSize.s6,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusColor(
                        getStatusString(userOverviewApiVar?.data?.status),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    getStatusString(userOverviewApiVar?.data?.status),
                    style: StylesManager.getRegularStyle(
                      color: ColorManager.greyNeutral3,
                      fontSize: FontSize.sBody3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: AppSize.s35),
          height: AppSize.s30,
          width: AppSize.s1,
          decoration: BoxDecoration(
            color: ColorManager.greyNeutral.withOpacity(0.25),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSize.s15),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: AppSize.s35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userOverviewApiVar?.data?.remainingRxtx == Constants.nullValue
                    ? Constants.dash
                    : (userOverviewApiVar?.data?.remainingRxtx)! < 0
                        ? "0"
                        : "${userOverviewApiVar?.data?.remainingRxtx}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: FontSize.sHeading4,
                    ),
              ),
              Text(
                AppStrings.userOverviewDailyTaffic,
                style: StylesManager.getRegularStyle(
                  color: ColorManager.greyNeutral3,
                  fontSize: FontSize.sBody3,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userOverviewApiVar?.data?.remainingUptime == Constants.nullValue
                  ? Constants.dash
                  : (userOverviewApiVar?.data?.remainingUptime)! < 0
                      ? "0"
                      : "${userOverviewApiVar?.data?.remainingUptime}",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: FontSize.sHeading4,
                  ),
            ),
            Text(
              AppStrings.userOverviewUptime,
              style: StylesManager.getRegularStyle(
                color: ColorManager.greyNeutral3,
                fontSize: FontSize.sBody3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _getUserDetailsContent() {
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
              AppStrings.userOverviewUserInformation,
              context,
            ),
            SingleListTile(
              list: _viewModel.listOfUserInforms(userOverviewApiVar),
            ),
            Container(
              margin: const EdgeInsets.only(top: AppSize.s25),
              child: getCardTitle(
                IconsAssets.userServiceInformation,
                AppStrings.userOverviewServiceInformation,
                context,
              ),
            ),
            SingleListTile(
              list: _viewModel.listOfServiceInforms(userOverviewApiVar),
            ),
          ],
        ),
      ),
    );
  }

  void _openActions(SingleUserAction selectedAction, context) async {
    switch (selectedAction.text) {
      case AppStrings.userActionDelete:
        _makeDeleteAction(context);
        break;
      case AppStrings.userActionRename:
        _makeRenameAction(context);
        break;
      case AppStrings.userActionChangeProfile:
        await _makeChangingProfileAction(context);
        break;
      case AppStrings.userActionDeposit:
        _makeDepositAction(context);
        break;
      case AppStrings.userActionWithdrawal:
        _makeWithdrawalAction(context);
        break;
      case AppStrings.userActionPay:
        _makePayAction(context);
        break;
      case AppStrings.userActionActivate:
        Nav.navTo(context, Routes.userActivationInformsRoute);
        break;
      case AppStrings.userActionEdit:
        Nav.navTo(context, Routes.editUserRoute);
        break;
      case AppStrings.userActionExtend:
        Nav.navTo(context, Routes.extendUserRoute);
        break;
    }
  }

  void _makeRenameAction(context) {
    _newUsernameController = TextEditingController(
      text: userOverviewApiVar?.data?.username,
    );
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getRenameUsernameDialogContent(),
        AppStrings.userActionRename,
        AppStrings.userActionRenameDialogTitle,
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

  Future<void> _makeChangingProfileAction(context) async {
    selectedprofile = Constants.nullValue;
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getChangeProfileDialogContent(),
        AppStrings.userActionChange,
        AppStrings.userActionProfileDialogTitle,
        IconsAssets.profileUserAction,
        () {
          if (selectedprofile != Constants.nullValue) {
            Nav.popRoute(context);
            _viewModel.changeProfile(selectedprofile?.id);
          }
        },
      ),
    );
    if (profileList == Constants.nullValue ||
        profileList?.length == Constants.zeroNum) {
      await _viewModel.getProfileList();
    }
  }

  Widget _getChangeProfileDialogContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m10),
          child: Text(
            "Profile",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: ColorManager.greyNeutral5,
                ),
          ),
        ),
        StreamBuilder<List<ProfileData>>(
          stream: _viewModel.outputProfileList,
          builder: (context, snapshot0) {
            if (profileList == Constants.nullValue ||
                profileList?.length == Constants.zeroNum) {
              profileList = snapshot0.data;
            }
            return DropDownComponent<ProfileData>(
              isThisServersDropdown: Constants.falseBool,
              isThisActionDropdown: Constants.trueBool,
              hintStr: AppStrings.changeProfileHint,
              items: profileList ?? [],
              doOtherThings: (val) {
                selectedprofile = val;
              },
              displayFn: (item) => (item as ProfileData).name,
              dropdownColor: ColorManager.greyNeutral.withOpacity(0.25),
              textAndHintColor: ColorManager.blackNeutral,
            );
          },
        ),
      ],
    );
  }

  void _makeDeleteAction(context) {
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getDeleteDialogContent(),
        AppStrings.userActionDelete,
        AppStrings.userActionDeleteDialogTitle,
        IconsAssets.trashUserAction,
        () {
          Nav.popRoute(context);
          _viewModel.deleteUser(context);
        },
      ),
    );
  }

  Widget _getDeleteDialogContent() {
    return Text(
      "${AppStrings.actionDeleteUserdialogTitle} ${userOverviewApiVar?.data?.username}?",
      style: Theme.of(context).textTheme.titleMedium,
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

  Widget _getDepositDialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: getActionTextFieldInput(
            context,
            _amountController,
            (val) {},
            AppStrings.amountInputtitle,
            Constants.trueBool,
            TextInputType.number,
          ),
        ),
        getActionTextFieldInput(
          context,
          _commentController,
          (val) {},
          AppStrings.commentInputtitle,
          Constants.falseBool,
        )
      ],
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: getActionTextFieldInput(
            context,
            _amountController,
            (val) {},
            AppStrings.amountInputtitle,
            Constants.trueBool,
            TextInputType.number,
          ),
        ),
        getActionTextFieldInput(
          context,
          _commentController,
          (val) {},
          AppStrings.commentInputtitle,
          Constants.falseBool,
        )
      ],
    );
  }

  void _makePayAction(context) {
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getPayDebtDialogContent(),
        AppStrings.userActionPayDebt,
        AppStrings.payDebtInputDialogtitle,
        IconsAssets.moneyUserAction,
        _viewModel.paydebtInforms?.data?.total != Constants.nullValue &&
                _viewModel.paydebtInforms?.data?.total != Constants.zeroNum
            ? () {
                if (_amountController.text.isNotEmpty) {
                  if (_viewModel.paydebtInforms?.data?.total !=
                          Constants.nullValue &&
                      _viewModel.paydebtInforms?.data?.total !=
                          Constants.zeroNum) {
                    FocusScope.of(context).unfocus();
                    Nav.popRoute(context);
                    _viewModel.payDebtAction(
                      _amountController.text,
                      _commentController.text,
                    );
                    _amountController.clear();
                    _commentController.clear();
                  }
                }
              }
            : Constants.nullValue,
      ),
    );
  }

  Widget _getPayDebtDialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: getActionTextFieldInput(
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
          child: getActionTextFieldInput(
            context,
            _commentController,
            (val) {},
            AppStrings.commentInputtitle,
            Constants.falseBool,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.totaldebtDialogText,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "${_viewModel.paydebtInforms?.data?.total}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}
