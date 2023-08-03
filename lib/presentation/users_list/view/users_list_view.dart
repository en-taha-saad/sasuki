import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/shared_widgets/get_custome_appbar.dart';
import 'package:sasuki/app/shared_widgets/get_loading_state_widget.dart';
import 'package:sasuki/app/shared_widgets/load_more.dart';
import 'package:sasuki/app/shared_widgets/get_empty_state_widget.dart';
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
import 'package:sasuki/app/shared_widgets/single_user_card.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/single_user_card_statistics.dart';
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
      } else {
        setState(() {
          loadingMoreUsers = Constants.trueBool;
        });
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
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ) ??
            _getScreenView();
      },
    );
  }

  Widget _getScreenView() {
    return RefreshIndicator(
      onRefresh: () async {
        _usersListViewModel.getUsersListForPull(
          _dashboardViewModel.getDataStreamingly,
        );
      },
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
              getCustomAppBar(context, AppStrings.usersUsersList, false),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p25,
                ),
                child: StreamBuilder<UsersList>(
                  stream: _usersListViewModel.outputUsersListData,
                  builder: (context, outputUsersListData) {
                    return StreamBuilder<Dashboard>(
                        stream: _dashboardViewModel.outputDashboardData,
                        builder: (context, outputDashboardData) {
                          return SingleUserCardStatistics(
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
              if (!_usersListViewModel.isThereAddUserCreationPermission)
                SizedBox(
                  width: getScreenWidth(context) * 0.75,
                  child: _getSearchTextField(),
                ),
              if (_usersListViewModel.isThereAddUserCreationPermission)
                SizedBox(
                  width: getScreenWidth(context) * 0.6,
                  child: _getSearchTextField(),
                ),
              IconButton(
                onPressed: _showFilterDialog,
                icon: SvgPicture.asset(IconsAssets.filter),
              ),
              if (_usersListViewModel.isThereAddUserCreationPermission)
                InkWell(
                  onTap: () => Nav.navTo(context, Routes.addUserRoute),
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
          child: _getUsersList(),
        ),
      ],
    );
  }

  bool showClearIcon = Constants.falseBool;

  _getSearchTextField() {
    return Stack(
      children: [
        TextFormField(
          controller: _searchInputController,
          onEditingComplete: _searchUsers,
          onTap: () {
            setState(() {
              showClearIcon = Constants.trueBool;
            });
          },
          onFieldSubmitted: (value) {
            _searchUsers();
            setState(() {
              showClearIcon = Constants.falseBool;
            });
          },
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.whiteNeutral,
              ),
          decoration: InputDecoration(
            hintText: AppStrings.usersSearchusers,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: RadiusSizes.radius12,
            ),
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.greyNeutral3,
                ),
            fillColor: const Color(0xff3D4E78),
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
                    _searchUsers();
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

  _searchUsers() {
    FocusScope.of(context).unfocus();
    setState(() => loadFilteredUsers = Constants.trueBool);
    _usersListViewModel.getUserFromSearch();
  }

  bool hidLoadingMoreUsers = Constants.falseBool;

  _prepareUserList(List<UsersListData>? data) {
    // ignore: prefer_is_empty
    if (data?.length == Constants.oneNum || data?.length == Constants.zeroNum) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(
          Duration(seconds: Constants.oneNum.toInt()),
          () {
            if (mounted) {
              setState(() => loadFilteredUsers = Constants.falseBool);
            }
          },
        );
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(seconds: Constants.oneNum.toInt()),
        () {
          if (mounted) {
            setState(() {
              hidLoadingMoreUsers =
                  _usersListViewModel.totalUsers == data?.length;
            });
          }
        },
      );
    });
  }

  Widget _getUsersList() {
    return StreamBuilder<List<UsersListData>?>(
      stream: _usersListViewModel.outputUsersList,
      builder: (context, snapshot) {
        _prepareUserList(snapshot.data);
        return !loadFilteredUsers
            // ignore: prefer_is_empty
            ? snapshot.data?.length != Constants.zeroNum
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: loadMore<UsersListData>(
                      loadingMoreItems: loadingMoreUsers,
                      hidLoadingMoreItems: hidLoadingMoreUsers,
                      context: context,
                      singleItem: _singleUser,
                      data: snapshot.data ?? [],
                    ),
                  )
                : getEmptyStateWidget(
                    context,
                    () {
                      FocusScope.of(context).unfocus();
                      setState(() => loadFilteredUsers = true);
                      _usersListViewModel.refreshUsersList();
                    },
                  )
            : getLoadingStateWidget();
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
                  Nav.navTo(context, Routes.userDetailsRoute);
                  instance<UserDetailsViewModel>()
                      .getUserApiOverview(usersListData.id);
                },
                child: SingleUserCard(
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
    return LayoutBuilder(
      builder: (context, constraint) {
        return Dialog(
          insetAnimationCurve: Curves.fastLinearToSlowEaseIn,
          insetPadding: EdgeInsets.only(
            left: Constants.zeroDouble,
            right: Constants.zeroDouble,
            top: MediaQuery.of(context).size.height * 0.08,
            bottom: constraint.maxHeight > 750
                ? constraint.maxHeight > 800
                    ? MediaQuery.of(context).size.height * 0.25
                    : MediaQuery.of(context).size.height * 0.19
                : 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s0),
          ),
          backgroundColor: ColorManager.backgroundCenter,
          child: _filterDialogContent(context),
        );
      },
    );
  }

  _filterDialogContent(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff323F63),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurRadius: AppSize.s2,
              offset: const Offset(0, AppSize.s2),
            ),
          ],
        ),
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
          style: Theme.of(context).textTheme.labelLarge,
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
                textAndHintColor: ColorManager.whiteNeutral,
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
