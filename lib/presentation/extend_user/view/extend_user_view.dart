import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/card_title.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/get_action_dialog_content.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/showdialog.dart';
import 'package:sasuki/app/shared_widgets/userdetails_list_tile.dart';
import 'package:sasuki/domain/models/activation_informs/activation_method.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/extend_user_informs/allowed_extersion_methods.dart';
import 'package:sasuki/domain/models/extend_user_informs/extend_user_informs.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/extend_user/viewmodel/extend_user_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';

class ExtendUserView extends StatefulWidget {
  const ExtendUserView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExtendUserViewState createState() => _ExtendUserViewState();
}

class _ExtendUserViewState extends State<ExtendUserView> {
  final UserDetailsViewModel _userDetailsViewModel =
      instance<UserDetailsViewModel>();
  final DashboardViewModel _dashboardViewModel = instance<DashboardViewModel>();
  final ExtendUserViewModel _extendUserViewModel =
      instance<ExtendUserViewModel>();
  UserOverviewApi? userOverviewApiVar;
  ExtendUserInforms? extendUserInformsVar;
  Dashboard? dashboardVar;
  List<ActivationMethod> activationMethods = [
    ActivationMethod(
      AppStrings.activationMethod1,
      AppStrings.activationMethodRequiredSentString1,
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
  Extension? extensionValue;
  List<Extension>? listOfExtensionValue;
  _bind() async {
    _dashboardViewModel.getDataStreamingly();
    _userDetailsViewModel.getUserDataStreamingly();
    _extendUserViewModel.getExtendUserInforms(
      _userDetailsViewModel.commingUserId!,
    );
    _extendUserViewModel.outputExtendUserInforms.listen(
      (event) {
        if (mounted) {
          debugPrint("${event.status}");
          // check whether the state object is in tree
          setState(() => extendUserInformsVar = event);
        }
      },
    );
    _extendUserViewModel.outputExtensionInforms.listen(
      (event) {
        if (mounted) {
          debugPrint("${event.status}");
          // check whether the state object is in tree
          setState(() => listOfExtensionValue = event.data);
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
  }

  @override
  void dispose() {
    _userDetailsViewModel.dispose();
    _dashboardViewModel.dispose();
    _extendUserViewModel.dispose();
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
      stream: _extendUserViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await _extendUserViewModel.getExtendUserInformsStreamingly(
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
                  top: AppMargin.m20,
                  bottom: AppMargin.m25,
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
                    AppStrings.extendUserTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: ColorManager.secondary,
                child: _getExtendServiceContent(),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m25,
            vertical: AppMargin.m50,
          ),
          child: ElevatedButtonWidget(
            name: AppStrings.extendUserFloatingButtonTitle,
            onPressed: _extendUser,
          ),
        ),
      ],
    );
  }

  _getExtendServiceContent() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppMargin.m138,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getCardTitle(
            IconsAssets.maximizecircleUserAction,
            AppStrings.userActionExtend,
            context,
          ),
          SingleListTile(
            list: _extendUserViewModel.listOfExtendUserInforms(
              extendUserInformsVar,
            ),
          ),
        ],
      ),
    );
  }

  _extendUser() {
    if (listOfExtensionValue == Constants.nullValue ||
        listOfExtensionValue?.length == Constants.zeroNum) {
      _extendUserViewModel.getExtensionsInforms(
        (userOverviewApiVar?.data?.profileId)!,
      );
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showActionDialog(
      context,
      getActionDialogContent(
        context,
        _getExtendDialogContent(),
        AppStrings.userActionExtend,
        AppStrings.extendInputDialogtitle,
        IconsAssets.maximizecircleUserAction,
        _extendUserMethod,
      ),
    );
  }

  Widget _getExtendDialogContent() {
    return StatefulBuilder(
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
              ),
            ),
            DropDownComponent<Extension>(
              isThisServersDropdown: Constants.falseBool,
              hintStr: AppStrings.changeProfileHint,
              items: listOfExtensionValue ?? [],
              doOtherThings: (val) {
                extensionValue = val;
              },
              displayFn: (item) =>
                  (item as Extension).name ?? Constants.emptyStr,
            )
          ],
        );
      },
    );
  }

  _extendUserMethod() {
    FocusScope.of(context).unfocus();
    Nav.popRoute(context);
    _extendUserViewModel.extendUser(
      selectedActivationMethod ?? activationMethods.first,
      extensionValue?.id ?? listOfExtensionValue?.first.id,
    );
  }
}