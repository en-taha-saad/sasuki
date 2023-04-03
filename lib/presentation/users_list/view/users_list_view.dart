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
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/item_card.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/single_card_statistics.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/filter_lists/connection_list.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/filter_lists/status_list.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';
import 'package:sasuki/presentation/users_list/viewmodel/users_list_viewmodel.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  final DashboardViewModel _dashboardViewModel = instance<DashboardViewModel>();
  final UsersListViewModel _usersListViewModel = instance<UsersListViewModel>();
  final ScrollController _scrollController = ScrollController();
  final _searchInputController = TextEditingController();
  bool loadingMoreUsers = Constants.falseBool;
  bool loadFilteredUsers = Constants.falseBool;
  bool showFilterWidget = Constants.falseBool;
  List<SingleParentData>? parentList;
  List<ProfileData>? profileList;
  List<StatusFilterList>? statusFilterList;
  List<ConnectionFilterList>? connectionFilterList;
  SingleParentData? selectedparent;
  ProfileData? selectedprofile;
  StatusFilterList? selectedstatusFilter;
  ConnectionFilterList? selectedconnectionFilter;

  _bind() async {
    await _usersListViewModel.start();
    _dashboardViewModel.getDataStreamingly();
    _handleNext();
    _searchInputController.addListener(
      () {
        _usersListViewModel.setSearchInput(_searchInputController.text);
      },
    );
  }

  @override
  void dispose() {
    _dashboardViewModel.dispose();
    _usersListViewModel.dispose();
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
          loadingMoreUsers = Constants.trueBool;
        });
        _usersListViewModel.getNextUsersList();
        if (_scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loadingMoreUsers = Constants.falseBool;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _usersListViewModel.outputState,
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
      onRefresh: () async => _usersListViewModel.getUsersListForPull(
        _dashboardViewModel.getDataStreamingly,
      ),
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      backgroundColor: ColorManager.whiteNeutral,
      color: ColorManager.backgroundCenter,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() => showFilterWidget = Constants.falseBool);
        },
        child: _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
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
                    AppStrings.usersUsersList,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Container(),
                ],
              ),
              const SizedBox(height: AppSize.s20),
              StreamBuilder<UsersList>(
                stream: _usersListViewModel.outputUsersListData,
                builder: (context, outputUsersListData) {
                  return StreamBuilder<Dashboard>(
                      stream: _dashboardViewModel.outputDashboardData,
                      builder: (context, outputDashboardData) {
                        return SingleCardStatistics(
                          isShimmer: Constants.falseBool,
                          totalUsers:
                              "${outputUsersListData.data?.total ?? Constants.dash}",
                          activeUsers:
                              "${outputDashboardData.data?.data?.activeUsersCount ?? Constants.dash}",
                          expiredUsers:
                              "${outputDashboardData.data?.data?.expiredUsersCount ?? Constants.dash}",
                          onlineUsers:
                              "${outputDashboardData.data?.data?.usersOnlineCount ?? Constants.dash}",
                        );
                      });
                },
              ),
              const SizedBox(height: AppSize.s15),
              Row(
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
                      // TODO : Add code for add user
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
              const SizedBox(height: AppSize.s15),
            ],
          ),
        ),
        Expanded(
          child: _getUsersList(),
        ),
      ],
    );
  }

  _getSearchTextField() {
    return Stack(
      children: [
        TextFormField(
          controller: _searchInputController,
          onEditingComplete: _searchUsers,
          onFieldSubmitted: (value) => _searchUsers(),
          decoration: const InputDecoration(
            hintText: AppStrings.usersSearchusers,
            fillColor: ColorManager.greyshade1,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppMargin.m10,
            right: AppMargin.m12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _searchInputController.clear();
                  _searchUsers();
                },
                child: SvgPicture.asset(
                  IconsAssets.clearInput,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
              InkWell(
                onTap: _searchUsers,
                child: SvgPicture.asset(
                  height: AppSize.s18,
                  width: AppSize.s18,
                  IconsAssets.search,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _searchUsers() {
    FocusScope.of(context).unfocus();
    setState(() => loadFilteredUsers = Constants.trueBool);
    _usersListViewModel.getUserFromSearch();
  }

  Widget _getUsersList() {
    return StreamBuilder<List<UsersListData>?>(
      stream: _usersListViewModel.outputUsersList,
      builder: (context, snapshot) {
        // ignore: prefer_is_empty
        if (snapshot.data?.length == Constants.oneNum ||
            snapshot.data?.length == Constants.zeroNum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(
              Duration(seconds: Constants.oneNum.toInt()),
              () => setState(() => loadFilteredUsers = Constants.falseBool),
            );
          });
        }
        return !loadFilteredUsers
            // ignore: prefer_is_empty
            ? snapshot.data?.length != Constants.zeroNum
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: loadingMoreUsers
                        ? Column(
                            children: [
                              _singleUser(snapshot.data, context),
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
                        : _singleUser(snapshot.data, context),
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
                              setState(() => loadFilteredUsers = true);
                              _usersListViewModel.refreshUsersList();
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

  Widget _singleUser(List<UsersListData>? listOfUsers, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfUsers?.map(
            (usersListData) {
              return InkWell(
                onTap: () {
                  // TODO: Add code for user details
                  Nav.navTo(context, Routes.userDetailsRoute);
                  instance<UserDetailsViewModel>()
                      .getUserApiOverview(usersListData.id);
                },
                child: ItemCard(
                  fullName: usersListData.firstname.isNotEmpty
                      ? "${usersListData.firstname} ${usersListData.lastname}"
                      : Constants.dash,
                  profileName:
                      usersListData.profileDetails?.name ?? Constants.dash,
                  balance: usersListData.balance.isNotEmpty
                      ? usersListData.balance
                      : Constants.dash,
                  expireOn: usersListData.expiration,
                  status: _getUserStatusString(usersListData),
                  statusColor: _getUserStatusColor(usersListData),
                  isOnline: usersListData.onlineStatus == Constants.oneNum,
                  username: usersListData.username,
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
      await _usersListViewModel.getParentList();
      if (profileList == Constants.nullValue ||
          profileList?.length == Constants.zeroDouble) {
        await _usersListViewModel.getProfileList();
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
                InkWell(
                  onTap: _resetFilters,
                  child: Text(
                    AppStrings.usersReset,
                    style: StylesManager.getSemiBoldStyle(
                      fontSize: FontSize.sButton,
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
    _usersListViewModel.setSearchInput(Constants.emptyStr);
    _usersListViewModel.getUserFromSearch();
    Nav.popRoute(context);
  }

  void _applyFilters() {
    setState(() {
      showFilterWidget = !showFilterWidget;
      loadFilteredUsers = Constants.trueBool;
    });
    _searchInputController.clear();
    _usersListViewModel.setSearchInput(Constants.emptyStr);
    _usersListViewModel.getUserFromSearch(
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
          style: StylesManager.getSemiBoldStyle(
            fontSize: FontSize.sButton,
          ),
        ),
        StreamBuilder<List<SingleParentData>?>(
          stream: _usersListViewModel.outputParentList,
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
          style: StylesManager.getSemiBoldStyle(
            fontSize: FontSize.sButton,
          ),
        ),
        StreamBuilder<List<StatusFilterList>?>(
          stream: _usersListViewModel.outputStatusList,
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
          style: StylesManager.getSemiBoldStyle(
            fontSize: FontSize.sButton,
          ),
        ),
        StreamBuilder<List<ConnectionFilterList>?>(
          stream: _usersListViewModel.outputConnectionList,
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
          style: StylesManager.getSemiBoldStyle(
            fontSize: FontSize.sButton,
          ),
        ),
        StreamBuilder<List<ProfileData>>(
          stream: _usersListViewModel.outputProfileList,
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
              ),
            );
          },
        ),
      ],
    );
  }

  _getUserStatusString(UsersListData usersListData) {
    return usersListData.enabled == Constants.zeroNum
        ? AppStrings.disabledUser
        : usersListData.status?.status == Constants.trueBool
            ? AppStrings.activeUsers
            : AppStrings.expiredUsers;
  }

  _getUserStatusColor(UsersListData usersListData) {
    return usersListData.enabled == Constants.zeroNum
        ? ColorManager.redAnnotations
        : usersListData.status?.status == Constants.trueBool
            ? ColorManager.greenAnnotations
            : ColorManager.orangeAnnotations;
  }
}
