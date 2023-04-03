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
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_status_vals.dart';
import 'package:sasuki/app/shared_widgets/card_title.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/userdetails_list_tile.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          AppSize.statusBarHeight(context),
          const SizedBox(height: AppSize.s20),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
              top: AppMargin.m20,
              bottom: AppMargin.m15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getUserActions(context),
                const SizedBox(height: AppSize.s20),
                _getStatisticsCard(context),
                const SizedBox(height: AppSize.s15),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: _getUserDetailsContent(),
            color: ColorManager.secondary,
          ),
        ],
      ),
    );
  }

  AppBar _getUserActions(context) {
    return AppBar(
      elevation: AppSize.s0,
      backgroundColor: Colors.transparent,
      centerTitle: Constants.trueBool,
      leadingWidth: AppSize.s10,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      leading: InkWell(
        child: SvgPicture.asset(IconsAssets.back),
        onTap: () => Nav.popRoute(context),
      ),
      title: Text(
        AppStrings.userOverviewTitle,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        PopupMenuButton<SingleUserAction>(
          onSelected: (SingleUserAction choice) =>
              _openActions(choice, context),
          color: ColorManager.secondary,
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
          padding: const EdgeInsets.all(AppPadding.p10),
          splashRadius: AppSize.s20,
          position: PopupMenuPosition.over,
          shape: RoundedRectangleBorder(
            borderRadius: RadiusSizes.radius12,
            side: const BorderSide(
              color: ColorManager.greyNeutral,
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
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SvgPicture.asset(
                        choice.icon!,
                        height: AppSize.s20,
                        width: AppSize.s20,
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

  Container _getStatisticsCard(context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.s15,
        horizontal: AppSize.s20,
      ),
      height: AppSize.s80,
      decoration: BoxDecoration(
        color: ColorManager.primaryshade1,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.userOverviewStatus,
                style: Theme.of(context).textTheme.headlineMedium,
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
                    style: StylesManager.getSemiBoldStyle(
                      color: ColorManager.greyNeutral3,
                      fontSize: FontSize.sSubtitle5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: AppSize.s30,
            width: AppSize.s1,
            decoration: BoxDecoration(
              color: ColorManager.greyNeutral.withOpacity(0.25),
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSize.s15),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userOverviewApiVar?.data?.remainingRxtx ?? Constants.dash}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                AppStrings.userOverviewDailyTaffic,
                style: StylesManager.getSemiBoldStyle(
                  color: ColorManager.greyNeutral3,
                  fontSize: FontSize.sSubtitle5,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userOverviewApiVar?.data?.remainingUptime ?? Constants.dash}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                AppStrings.userOverviewUptime,
                style: StylesManager.getSemiBoldStyle(
                  color: ColorManager.greyNeutral3,
                  fontSize: FontSize.sSubtitle5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getUserDetailsContent() {
    return Container(
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
          UserDetailsListTile(
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
          UserDetailsListTile(
            list: _viewModel.listOfServiceInforms(userOverviewApiVar),
          ),
        ],
      ),
    );
  }

  _showDialog(BuildContext context, Widget? child) {
    return showDialog(
      context: context,
      barrierColor: ColorManager.primaryshade1.withOpacity(AppSize.s0point4),
      barrierDismissible: Constants.falseBool,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p15,
              vertical: AppPadding.p48,
            ),
            decoration: BoxDecoration(
              color: ColorManager.secondary,
              shape: BoxShape.rectangle,
              borderRadius: RadiusSizes.radius35,
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _getDialogContent(
    BuildContext context,
    Widget child,
    String buttonText,
    String dialogTitle,
    String dialogTitleIcon,
    Function()? onPressed,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: AppMargin.m10),
                child: SvgPicture.asset(
                  dialogTitleIcon,
                  height: AppSize.s20,
                  width: AppSize.s20,
                  // ignore: deprecated_member_use
                  color: ColorManager.greyNeutral,
                ),
              ),
              Text(
                dialogTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorManager.greyNeutral,
                    ),
              ),
            ],
          ),
        ),
        child,
        Container(
          margin: const EdgeInsets.only(top: AppMargin.m40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Nav.popRoute(context),
                child: Text(
                  AppStrings.cancelButton,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              ElevatedButtonWidget(
                name: buttonText,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getTextFieldInput(
    controller,
    Function(String)? onFieldSubmitted,
    String textFieldLabel, [
    bool? autoFocus,
    TextInputType? keyboardType,
  ]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m10),
          child: Text(
            textFieldLabel,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          autofocus: autoFocus ?? Constants.falseBool,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          onFieldSubmitted: onFieldSubmitted,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
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
        // TODO: implement activate user
        // Nav.navTo(context, Routes.userActivationInformsRoute);
        break;
      case AppStrings.userActionEdit:
        // TODO: implement edit user
        // Nav.navTo(context, Routes.editUserRoute);
        break;
      case AppStrings.userActionExtend:
        // TODO: implement extend user
        // Nav.navTo(context, Routes.extendUserRoute);
        break;
    }
  }

  void _makeRenameAction(context) {
    _newUsernameController = TextEditingController(
      text: userOverviewApiVar?.data?.username,
    );
    _showDialog(
      context,
      _getDialogContent(
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
    return _getTextFieldInput(
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
    _showDialog(
      context,
      _getDialogContent(
        context,
        _getChangeProfileDialogContent(),
        AppStrings.userActionChangeProfile,
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
    return StreamBuilder<List<ProfileData>>(
      stream: _viewModel.outputProfileList,
      builder: (context, snapshot0) {
        if (profileList == Constants.nullValue ||
            profileList?.length == Constants.zeroNum) {
          profileList = snapshot0.data;
        }
        return DropDownComponent<ProfileData>(
          isThisServersDropdown: Constants.falseBool,
          hintStr: AppStrings.changeProfileHint,
          items: profileList ?? [],
          doOtherThings: (val) {
            selectedprofile = val;
          },
          displayFn: (item) => (item as ProfileData).name,
        );
      },
    );
  }

  void _makeDeleteAction(context) {
    _showDialog(
      context,
      _getDialogContent(
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
    _showDialog(
      context,
      _getDialogContent(
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
          child: _getTextFieldInput(
            _amountController,
            (val) {},
            AppStrings.amountInputtitle,
            Constants.trueBool,
            TextInputType.number,
          ),
        ),
        _getTextFieldInput(
          _commentController,
          (val) {},
          AppStrings.commentInputtitle,
          Constants.falseBool,
        )
      ],
    );
  }

  void _makeWithdrawalAction(context) {
    _showDialog(
      context,
      _getDialogContent(
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
          child: _getTextFieldInput(
            _amountController,
            (val) {},
            AppStrings.amountInputtitle,
            Constants.trueBool,
            TextInputType.number,
          ),
        ),
        _getTextFieldInput(
          _commentController,
          (val) {},
          AppStrings.commentInputtitle,
          Constants.falseBool,
        )
      ],
    );
  }

  void _makePayAction(context) {
    _showDialog(
      context,
      _getDialogContent(
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
          child: _getTextFieldInput(
            _amountController,
            (val) {},
            AppStrings.amountInputtitle,
            Constants.trueBool,
            TextInputType.number,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m25),
          child: _getTextFieldInput(
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
