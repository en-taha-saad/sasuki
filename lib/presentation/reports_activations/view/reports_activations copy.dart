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
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/reports_activations/viewmodel/reports_activations_viewmodel.dart';
import 'package:intl/intl.dart' as intl;

class ReportsActivationsView extends StatefulWidget {
  const ReportsActivationsView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReportsActivationsViewState createState() => _ReportsActivationsViewState();
}

class _ReportsActivationsViewState extends State<ReportsActivationsView> {
  final ReportsActivationsViewModel _viewModel =
      instance<ReportsActivationsViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool loadingMoreActivations = Constants.falseBool;
  bool loadFilteredActivations = Constants.falseBool;
  bool showFilterWidget = Constants.falseBool;
  List<ProfileData>? profileList;
  ProfileData? selectedprofile;

  _bind() {
    _viewModel.start();
    _handleNext();
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

  _handleNext() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          loadingMoreActivations = Constants.trueBool;
        });
        _viewModel.getNextReportsActivations();
        if (_scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loadingMoreActivations = Constants.falseBool;
          });
        }
      } else {
        setState(() {
          loadingMoreActivations = Constants.trueBool;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await _viewModel.getActivationsReportsStreamingly();
              },
            ) ??
            _getScreenView();
      },
    );
  }

  Widget _getScreenView() {
    return RefreshIndicator(
      onRefresh: () async => _viewModel.getReportsActivationsForPull(),
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      backgroundColor: ColorManager.whiteNeutral,
      color: ColorManager.backgroundCenter,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(
            () {
              showFilterWidget = Constants.falseBool;
            },
          );
        },
        child: _getContentWidget(context),
      ),
    );
  }

  Widget _getContentWidget(context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
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
          Container(
            width: MediaQuery.of(context).size.width,
            color: ColorManager.secondary,
            child: Container(
              margin: const EdgeInsets.only(
                bottom: AppMargin.m50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: ColorManager.whiteNeutral.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s20,
                      vertical: AppSize.s10,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: AppSize.s20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: AppSize.s10),
                              child: SvgPicture.asset(
                                IconsAssets.tickcircle,
                                theme: const SvgTheme(
                                  currentColor: ColorManager.whiteNeutral,
                                ),
                                // ignore: deprecated_member_use
                                color: ColorManager.whiteNeutral,
                              ),
                            ),
                            Text(
                              AppStrings.activationReports,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: ColorManager.whiteNeutral,
                                  ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: _showFilterDialog,
                          child: SvgPicture.asset(
                            IconsAssets.filter,
                            theme: const SvgTheme(
                              currentColor: ColorManager.whiteNeutral,
                            ),
                            // ignore: deprecated_member_use
                            color: ColorManager.whiteNeutral,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: _getActivationListContent(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    return StreamBuilder<ActivationsReports>(
      stream: _viewModel.outputReportsActivations,
      builder: (context, snapshot) {
        // ignore: prefer_is_empty
        if (snapshot.data?.data?.length == Constants.oneNum ||
            snapshot.data?.data?.length == Constants.zeroNum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(
              Duration(seconds: Constants.oneNum.toInt()),
              () =>
                  setState(() => loadFilteredActivations = Constants.falseBool),
            );
          });
        }
        return !loadFilteredActivations
            // ignore: prefer_is_empty
            ? snapshot.data?.data?.length != Constants.zeroNum
                ? loadingMoreActivations
                    ? SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          children: [
                            _singleActivation(
                              snapshot.data,
                              context,
                              _viewModel.dataCaptcha,
                            ),
                            const SizedBox(height: AppSize.s20),
                            const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorManager.whiteNeutral,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : _singleActivation(
                        snapshot.data,
                        context,
                        _viewModel.dataCaptcha,
                      )
                : Container(
                    margin: const EdgeInsets.only(top: AppMargin.m38),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.emptyState),
                          const SizedBox(height: AppSize.s20),
                          Text(
                            AppStrings.noUsersFound,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSize.s10),
                          IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              setState(() => loadFilteredActivations = true);
                              _viewModel.refreshReportsActivations();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: AppSize.s32,
                              color: ColorManager.greyNeutral,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorManager.whiteNeutral,
                  ),
                ),
              );
      },
    );
  }

  Widget _singleActivation(
    ActivationsReports? listOfActivations,
    BuildContext context,
    Captcha? dataCaptcha,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfActivations?.data?.map(
            (activation) {
              return InkWell(
                onTap: () {
                  // TODO: Navigate to activation details screen
                  // Nav.navTo(context, Routes.userDetailsRoute);
                },
                child: SingleActivationCard(
                  activation: activation,
                  dataCaptcha: dataCaptcha,
                ),
                // SingleActivationCard(
                //   fullName: usersListData.firstname.isNotEmpty
                //       ? "${usersListData.firstname} ${usersListData.lastname}"
                //       : Constants.dash,
                //   profileName:
                //       usersListData.profileDetails?.name ?? Constants.dash,
                //   balance: usersListData.balance.isNotEmpty
                //       ? usersListData.balance
                //       : Constants.dash,
                //   expireOn: usersListData.expiration,
                //   status: _getUserStatusString(usersListData),
                //   statusColor: _getUserStatusColor(usersListData),
                //   isOnline: usersListData.onlineStatus == Constants.oneNum,
                //   username: usersListData.username,
                // )
              );
            },
          ).toList() ??
          [],
    );
  }

  _showFilterDialog() async {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      barrierDismissible: Constants.falseBool,
      barrierColor: ColorManager.transparent,
      useSafeArea: Constants.trueBool,
      builder: (context) => _filterDialog(context),
    );
    if (profileList == Constants.nullValue ||
        profileList?.length == Constants.zeroDouble) {
      await _viewModel.getProfileList();
    }
    showFilterWidget = !showFilterWidget;
    setState(() {});
  }

  _filterDialog(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.fastLinearToSlowEaseIn,
      insetPadding: const EdgeInsets.only(
        left: Constants.zeroDouble,
        right: Constants.zeroDouble,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s0),
      ),
      backgroundColor: ColorManager.backgroundCenter,
      child: _filterDialogContent(context),
    );
  }

  _filterDialogContent(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorManager.backgroundCenter,
        padding: const EdgeInsets.only(
          right: AppMargin.m25,
          left: AppMargin.m25,
          bottom: AppMargin.m35,
          top: AppMargin.m20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: AppSize.s25),
                Text(
                  AppStrings.usersAdvancedFilter,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                InkWell(
                  child: SvgPicture.asset(
                    IconsAssets.cancel,
                    height: AppSize.s24,
                    width: AppSize.s24,
                  ),
                  onTap: () {
                    setState(() => showFilterWidget = !showFilterWidget);
                    Nav.popRoute(context);
                  },
                ),
              ],
            ),
            _getProfileDropdown(AppStrings.usersProfile, context),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _resetFilters,
                  child: Text(
                    AppStrings.usersReset,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                ElevatedButtonWidget(
                  name: AppStrings.usersApply,
                  onPressed: _applyFilters,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      selectedprofile = Constants.nullValue;
      showFilterWidget = !showFilterWidget;
      loadFilteredActivations = Constants.trueBool;
    });
    _viewModel.getFilteredActivationsList();
    Nav.popRoute(context);
  }

  void _applyFilters() {
    setState(() {
      showFilterWidget = !showFilterWidget;
      loadFilteredActivations = Constants.trueBool;
    });
    _viewModel.getFilteredActivationsList(
      profileId: selectedprofile?.id,
    );
    Nav.popRoute(context);
  }

  _getProfileDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s20),
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        StreamBuilder<List<ProfileData>>(
          stream: _viewModel.outputProfileList,
          builder: (_, snapshot0) {
            if (profileList == Constants.nullValue ||
                profileList?.length == Constants.zeroNum) {
              profileList = snapshot0.data;
            }
            debugPrint("profileList: $profileList");
            // ignore: prefer_is_empty
            return Container(
              margin: const EdgeInsets.only(top: AppMargin.m15),
              child: DropDownComponent<ProfileData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersParentHint,
                items: profileList ?? [],
                doOtherThings: (val) {
                  selectedprofile = val;
                },
                displayFn: (item) => (item as ProfileData).name,
                textAndHintColor: ColorManager.whiteNeutral,
              ),
            );
          },
        ),
      ],
    );
  }
}

class SingleActivationCard extends StatelessWidget {
  const SingleActivationCard({this.dataCaptcha, this.activation, Key? key})
      : super(key: key);
  final Activation? activation;
  final Captcha? dataCaptcha;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getSingleLabeledData(
                context,
                AppStrings.userOverviewusername,
                activation?.userDetails?.username ?? Constants.dash,
              ),
              Text(
                "${dataCaptcha?.data?.siteCurrency} ${intl.NumberFormat.decimalPattern().format(double.parse((activation?.price)!))}",
                style: StylesManager.getMediumStyle(
                  fontSize: FontSize.sSubtitle5,
                ),
              ),
            ],
          ),
          _getSingleLabeledData(
            context,
            AppStrings.userNameHint,
            activation?.userDetails?.firstname != Constants.nullValue
                ? "${activation?.userDetails?.firstname} ${activation?.userDetails?.lastname ?? Constants.dash}"
                : Constants.dash,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m10),
            child: _getSingleLabeledData(
              context,
              AppStrings.manager,
              activation?.managerDetails?.username ?? Constants.dash,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: AppSize.s22,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m15,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s15),
                  color: ColorManager.greyNeutral,
                ),
                child: Center(
                  child: Text(
                    activation?.profileDetails?.name ?? Constants.dash,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: ColorManager.blackNeutral,
                        ),
                  ),
                ),
              ),
              Text(
                formatDateTime((activation?.createdAt)!),
                style: StylesManager.getMediumStyle(
                  fontSize: FontSize.sCaption1,
                  color: ColorManager.greyNeutral,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m25),
            child: Divider(
              color: ColorManager.greyNeutral.withOpacity(
                AppSize.s0point25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String inputDateTime) {
    DateTime parsedDateTime = DateTime.parse(inputDateTime);
    intl.DateFormat outputFormat = intl.DateFormat('dd, MMMM yyyy | HH:mm:ss');
    String formattedDateTime = outputFormat.format(parsedDateTime);
    return formattedDateTime;
  }

  Widget _getSingleLabeledData(
    BuildContext context,
    String? label,
    String? value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: AppMargin.m15),
          width: 60,
          child: Text(
            label!,
            style: StylesManager.getMediumStyle(
              fontSize: FontSize.sCaption1,
              color: ColorManager.greyNeutral,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            value!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
