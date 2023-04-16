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
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/item_card.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/single_card_statistics.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';

class ManagersListView extends StatefulWidget {
  const ManagersListView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManagersListViewState createState() => _ManagersListViewState();
}

class _ManagersListViewState extends State<ManagersListView> {
  final ManagersListViewModel _managersListViewModel =
      instance<ManagersListViewModel>();
  final ScrollController _scrollController = ScrollController();
  final _searchInputController = TextEditingController();
  bool loadingMoreManagers = Constants.falseBool;
  bool loadFilteredManagers = Constants.falseBool;
  bool showFilterWidget = Constants.falseBool;
  List<SingleManagerData>? parentManagerList;
  SingleManagerData? selectedparentManager;

  _bind() async {
    await _managersListViewModel.start();
    _handleNext();
    _searchInputController.addListener(
      () {
        _managersListViewModel.setSearchInput(_searchInputController.text);
      },
    );
  }

  @override
  void dispose() {
    _managersListViewModel.dispose();
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
          loadingMoreManagers = Constants.trueBool;
        });
        _managersListViewModel.getNextManagersList();
        if (_scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loadingMoreManagers = Constants.falseBool;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _managersListViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(),
              () async {},
            ) ??
            _getScreenView();
      },
    );
  }

  Widget _getScreenView() {
    return RefreshIndicator(
      onRefresh: () async => _managersListViewModel.refreshManagersList(),
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      backgroundColor: ColorManager.whiteNeutral,
      color: ColorManager.backgroundCenter,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(
            () {
              showFilterWidget = Constants.falseBool;
              showClearIcon = Constants.falseBool;
            },
          );
        },
        child: _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      children: [
        Container(
          color: ColorManager.primaryshade1,
          child: Column(
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
                          AppStrings.managersListScreen,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: 18,
                              ),
                        ),
                        Container(),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),

                    /// TODO: add header widget
                    // StreamBuilder<UsersList>(
                    //   stream: _managersListViewModel.outputUsersListData,
                    //   builder: (context, outputUsersListData) {
                    //     return StreamBuilder<Dashboard>(
                    //         stream: _dashboardViewModel.outputDashboardData,
                    //         builder: (context, outputDashboardData) {
                    //           return SingleCardStatistics(
                    //             isShimmer: Constants.falseBool,
                    //             totalUsers:
                    //                 "${outputUsersListData.data?.total ?? Constants.dash}",
                    //             activeUsers:
                    //                 "${outputDashboardData.data?.data?.activeUsersCount ?? Constants.dash}",
                    //             expiredUsers:
                    //                 "${outputDashboardData.data?.data?.expiredUsersCount ?? Constants.dash}",
                    //             onlineUsers:
                    //                 "${outputDashboardData.data?.data?.usersOnlineCount ?? Constants.dash}",
                    //           );
                    //         });
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s15),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getScreenWidth(context) * 0.6,
                child: _getSearchTextField(),
              ),
              InkWell(
                onTap: _showFilterDialog,
                child: SvgPicture.asset(
                  IconsAssets.filter,
                  width: AppSize.s18,
                  height: AppSize.s18,
                ),
              ),
              InkWell(
                onTap: () {
                  /// TODO: add manager
                  // Nav.navTo(context, Routes.addUserRoute);
                },
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p7),
                  decoration: const BoxDecoration(
                    color: ColorManager.primaryshade1,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    IconsAssets.add,
                    width: AppSize.s24,
                    height: AppSize.s24,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s15),
        Expanded(
          child: _getManagersList(),
        ),
      ],
    );
  }

// _getManagersList
// _searchUsers
  bool showClearIcon = Constants.falseBool;
  _getSearchTextField() {
    return Stack(
      children: [
        TextFormField(
          controller: _searchInputController,
          onEditingComplete: _searchManagers,
          onTap: () {
            setState(() {
              showClearIcon = Constants.trueBool;
            });
          },
          onFieldSubmitted: (value) {
            _searchManagers();
            setState(() {
              showClearIcon = Constants.falseBool;
            });
          },
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.greyNeutral,
              ),
          decoration: InputDecoration(
            hintText: AppStrings.usersSearchusers,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.greyNeutral3,
                ),
            fillColor: ColorManager.greyshade1,
            prefixIcon: Transform.scale(
              scale: 0.35,
              child: SvgPicture.asset(
                IconsAssets.search,
                fit: BoxFit.cover,
                theme: const SvgTheme(
                  currentColor: ColorManager.greyNeutral3,
                ),
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral3,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            right: AppMargin.m16,
            top: AppMargin.m14,
          ),
          alignment: Alignment.centerRight,
          child: showClearIcon
              ? InkWell(
                  onTap: () {
                    setState(
                      () {
                        showClearIcon = Constants.falseBool;
                      },
                    );
                    FocusScope.of(context).unfocus();
                    _searchInputController.clear();
                    _searchManagers();
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 21,
                    color: ColorManager.greyNeutral3,
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  _searchManagers() {
    FocusScope.of(context).unfocus();
    setState(() => loadFilteredManagers = Constants.trueBool);
    _managersListViewModel.getManagerFromSearch();
  }

  Widget _getManagersList() {
    return StreamBuilder<ManagerListDetails>(
      stream: _managersListViewModel.outputManagersList,
      builder: (context, snapshot) {
        // ignore: prefer_is_empty
        if (snapshot.data?.data?.length == Constants.oneNum ||
            snapshot.data?.data?.length == Constants.zeroNum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(
              Duration(seconds: Constants.oneNum.toInt()),
              () => setState(() => loadFilteredManagers = Constants.falseBool),
            );
          });
        }
        return !loadFilteredManagers
            // ignore: prefer_is_empty
            ? snapshot.data?.data?.length != Constants.zeroNum
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: loadingMoreManagers
                        ? Column(
                            children: [
                              _singleManager(snapshot.data?.data, context),
                              const SizedBox(height: AppSize.s20),
                              const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorManager.whiteNeutral,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : _singleManager(snapshot.data?.data, context),
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
                              setState(() => loadFilteredManagers = true);
                              _managersListViewModel.refreshManagersList();
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

  Widget _singleManager(
    List<SingleManagerDetails>? listOfManagers,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfManagers?.map(
            (managersListData) {
              return InkWell(
                onTap: () {
                  /// TODO: Navigate to manager details
                  // Nav.navTo(context, Routes.userDetailsRoute);
                  // instance<UserDetailsViewModel>()
                  //     .getManagerApiOverview(managersListData.id!);
                },
                child: ItemCard(
                  fullName: managersListData.firstname != Constants.nullValue ||
                          managersListData.lastname != ""
                      ? "${managersListData.firstname} ${managersListData.lastname}"
                      : Constants.dash,
                  balance: managersListData.balance != Constants.nullValue ||
                          // ignore: unrelated_type_equality_checks
                          managersListData.balance != ""
                      ? "${managersListData.balance}"
                      : Constants.dash,
                  status: _getUserStatusString(managersListData),
                  statusColor: _getUserStatusColor(managersListData),
                  username: managersListData.username,
                ),
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
    if (parentList == Constants.nullValue ||
        parentList?.length == Constants.zeroDouble) {
      await _managersListViewModel.getParentList();
      if (profileList == Constants.nullValue ||
          profileList?.length == Constants.zeroDouble) {
        await _managersListViewModel.getProfileList();
      }
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
            _getParentDropdown(AppStrings.usersParent, context),
            _getStatusDropdown(AppStrings.usersStatus, context),
            _getConnectionDropdown(AppStrings.usersConnection, context),
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
      selectedparent = Constants.nullValue;
      selectedprofile = Constants.nullValue;
      selectedconnectionFilter = Constants.nullValue;
      selectedstatusFilter = Constants.nullValue;
      showFilterWidget = !showFilterWidget;
      loadFilteredUsers = Constants.trueBool;
    });
    _searchInputController.clear();
    _managersListViewModel.setSearchInput(Constants.emptyStr);
    _managersListViewModel.getUserFromSearch();
    Nav.popRoute(context);
  }

  void _applyFilters() {
    setState(() {
      showFilterWidget = !showFilterWidget;
      loadFilteredUsers = Constants.trueBool;
    });
    _searchInputController.clear();
    _managersListViewModel.setSearchInput(Constants.emptyStr);
    _managersListViewModel.getUserFromSearch(
      parentId: selectedparent?.id,
      profileId: selectedprofile?.id,
      connectionId: selectedconnectionFilter?.id,
      statusId: selectedstatusFilter?.id,
    );
    Nav.popRoute(context);
  }

  _getParentDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s20),
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        StreamBuilder<List<SingleParentData>?>(
          stream: _managersListViewModel.outputParentList,
          builder: (_, snapshot0) {
            if (parentList == Constants.nullValue ||
                parentList?.length == Constants.zeroNum) {
              parentList = snapshot0.data;
            }
            debugPrint("parentList: $parentList");
            // ignore: prefer_is_empty
            return Container(
              margin: const EdgeInsets.only(top: AppMargin.m15),
              child: DropDownComponent<SingleParentData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersParentHint,
                items: parentList ?? [],
                doOtherThings: (val) {
                  selectedparent = val;
                },
                displayFn: (item) => (item as SingleParentData).username,
                textAndHintColor: ColorManager.whiteNeutral,
              ),
            );
          },
        ),
      ],
    );
  }

  _getStatusDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s20),
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        StreamBuilder<List<StatusFilterList>?>(
          stream: _managersListViewModel.outputStatusList,
          builder: (_, snapshot0) {
            if (statusFilterList == Constants.nullValue ||
                statusFilterList?.length == Constants.zeroNum) {
              statusFilterList = snapshot0.data;
            }
            // ignore: prefer_is_empty
            return Container(
              margin: const EdgeInsets.only(top: AppMargin.m15),
              child: DropDownComponent<StatusFilterList?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersStatusAny,
                items: statusFilterList ?? [],
                doOtherThings: (val) {
                  selectedstatusFilter = val;
                },
                displayFn: (item) => (item as StatusFilterList).name,
                textAndHintColor: ColorManager.whiteNeutral,
              ),
            );
          },
        ),
      ],
    );
  }

  _getConnectionDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s20),
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        StreamBuilder<List<ConnectionFilterList>?>(
          stream: _managersListViewModel.outputConnectionList,
          builder: (_, snapshot0) {
            if (connectionFilterList == Constants.nullValue ||
                connectionFilterList?.length == Constants.zeroNum) {
              connectionFilterList = snapshot0.data;
            }
            // ignore: prefer_is_empty
            return Container(
              margin: const EdgeInsets.only(top: AppMargin.m15),
              child: DropDownComponent<ConnectionFilterList?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersStatusAny,
                items: connectionFilterList ?? [],
                doOtherThings: (val) {
                  selectedconnectionFilter = val;
                },
                displayFn: (item) => (item as ConnectionFilterList).name,
                textAndHintColor: ColorManager.whiteNeutral,
              ),
            );
          },
        ),
      ],
    );
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
          stream: _managersListViewModel.outputProfileList,
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





  _getUserStatusString(SingleManagerDetails singleManagerDetails) {
    return singleManagerDetails.enabled == Constants.zeroNum
        ? AppStrings.disabledManager
        : AppStrings.enabledManager;
  }

  _getUserStatusColor(SingleManagerDetails singleManagerDetails) {
    return singleManagerDetails.enabled == Constants.zeroNum
        ? ColorManager.redAnnotations
        : ColorManager.greenAnnotations;
  }
}
