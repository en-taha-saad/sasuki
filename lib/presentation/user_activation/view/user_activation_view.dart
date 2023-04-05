import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/card_title.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/get_action_dialog_content.dart';
import 'package:sasuki/app/shared_widgets/get_actions_text_field.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/showdialog.dart';
import 'package:sasuki/app/shared_widgets/single_list_tile.dart';
import 'package:sasuki/domain/models/activation_informs/activation_informs.dart';
import 'package:sasuki/domain/models/activation_informs/activation_method.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/user_activation/viewmodel/user_activation_viewmodel.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';

class UserActivationView extends StatefulWidget {
  const UserActivationView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserActivationViewState createState() => _UserActivationViewState();
}

class _UserActivationViewState extends State<UserActivationView> {
  final UserDetailsViewModel _userDetailsViewModel =
      instance<UserDetailsViewModel>();
  final DashboardViewModel _dashboardViewModel = instance<DashboardViewModel>();
  final UserActivationViewModel _userActivationViewModel =
      instance<UserActivationViewModel>();
  UserOverviewApi? userOverviewApiVar;
  ActivationInforms? activationInformsVar;
  Dashboard? dashboardVar;
  bool isChecked = Constants.trueBool;
  bool showPinInput = Constants.falseBool;
  List<ActivationMethod> activationMethods = [
    ActivationMethod(
      AppStrings.activationMethod1,
      AppStrings.activationMethodRequiredSentString1,
    ),
    ActivationMethod(
      AppStrings.activationMethod2,
      AppStrings.activationMethodRequiredSentString2,
    ),
    ActivationMethod(
      AppStrings.activationMethod3,
      AppStrings.activationMethodRequiredSentString3,
    ),
    ActivationMethod(
      AppStrings.activationMethod4,
      AppStrings.activationMethodRequiredSentString4,
    ),
  ];
  ActivationMethod? selectedActivationMethod;
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _userPriceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  _bind() {
    _dashboardViewModel.getDataStreamingly();
    _userDetailsViewModel.getUserDataStreamingly();
    _userActivationViewModel.getActivationInforms(
      _userDetailsViewModel.commingUserId!,
    );
    _userActivationViewModel.outputActivationInforms.listen(
      (event) {
        if (mounted) {
          debugPrint("${event.status}");
          // check whether the state object is in tree
          setState(() => activationInformsVar = event);
        }
      },
    );
    _userDetailsViewModel.outputUserOverviewApi.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => userOverviewApiVar = event);
        }
      },
    );
    _dashboardViewModel.outputDashboardData.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => dashboardVar = event);
        }
      },
    );
    _pinController.addListener(
      () {
        _userActivationViewModel.setPin(_pinController.text);
      },
    );
    _commentController.addListener(
      () {
        _userActivationViewModel.setComment(_commentController.text);
      },
    );
  }

  @override
  void dispose() {
    _userDetailsViewModel.dispose();
    _dashboardViewModel.dispose();
    _userActivationViewModel.dispose();
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
      stream: _userActivationViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await _userActivationViewModel.getActivationInformsStreamingly(
                  _userDetailsViewModel.commingUserId!,
                );
              },
            ) ??
            _getScreenView(context);
      },
    );
  }

  Widget _getScreenView(context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              AppSize.statusBarHeight(context),
              Container(
                margin: const EdgeInsets.only(
                  right: AppMargin.m25,
                  left: AppMargin.m25,
                  bottom: AppMargin.m5,
                ),
                child: AppBar(
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
                    AppStrings.activateUserTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: ColorManager.secondary,
                child: _getActivateServiceContent(),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m25,
            vertical: AppMargin.m25,
          ),
          child: ElevatedButtonWidget(
            name: AppStrings.activateUserTitle,
            onPressed: () => _activateUser(context),
          ),
        ),
      ],
    );
  }

  _getActivateServiceContent() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppMargin.m115,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getCardTitle(
            IconsAssets.tickcircleUserAction,
            AppStrings.activateInputDialogtitle0,
            context,
          ),
          SingleListTile(
            list: _userActivationViewModel.listOfActivationInforms(
              userOverviewApiVar,
              activationInformsVar,
            ),
          ),
        ],
      ),
    );
  }

  _activateUser(context) {
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getActivateDialogContent(),
        AppStrings.userActionActivate,
        AppStrings.activateInputDialogtitle,
        IconsAssets.tickcircleUserAction,
        _activateUserMethod,
      ),
    );
  }

  _activateUserMethod() {
    FocusScope.of(context).unfocus();
    Nav.popRoute(context);
    _userActivationViewModel.activateUser(
      selectedActivationMethod ?? activationMethods.first,
      isChecked,
      _userPriceController.text.isNotEmpty
          ? int.parse(_userPriceController.text)
          : activationInformsVar?.data?.userPrice?.toInt(),
    );
  }

  Widget _getActivateDialogContent() {
    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: AppMargin.m25),
                child: DropDownComponent<ActivationMethod>(
                  isThisServersDropdown: Constants.falseBool,
                  hintStr: AppStrings.changeProfileHint,
                  items: activationMethods,
                  doOtherThings: (val) {
                    selectedActivationMethod = val;
                  },
                  displayFn: (item) => (item as ActivationMethod).method,
                  dropdownColor: ColorManager.greyNeutral.withOpacity(0.25),
                ),
              ),
              if (showPinInput)
                Container(
                  margin: const EdgeInsets.only(bottom: AppMargin.m25),
                  child: getActionTextFieldInput(
                    context,
                    _pinController,
                    (val) {},
                    AppStrings.activationPinInputtitle,
                    Constants.falseBool,
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(bottom: AppMargin.m25),
                child: getActionTextFieldInput(
                  context,
                  _userPriceController,
                  (val) {},
                  AppStrings.activationSalePriceInputtitle,
                  Constants.falseBool,
                  TextInputType.number,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: AppMargin.m25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Switch(
                          value: isChecked,
                          activeColor: ColorManager.blackNeutral,
                          onChanged: (bool value) {
                            setState(() => isChecked = value);
                          },
                        );
                      },
                    ),
                    const SizedBox(width: AppSize.s8),
                    Text(
                      AppStrings.moneyCollectedSwitch,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorManager.blackNeutral,
                          ),
                    ),
                  ],
                ),
              ),
              getActionTextFieldInput(
                context,
                _commentController,
                (val) {},
                AppStrings.activationNotesInputtitle,
                Constants.falseBool,
              ),
            ],
          );
        },
      ),
    );
  }
}
