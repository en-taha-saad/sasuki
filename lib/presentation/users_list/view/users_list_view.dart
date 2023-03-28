import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/opacity_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/item_card.dart';
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
                  // Nav.navTo(context, Routes.userDetailsRoute);
                  // instance<UserDetailsViewModel>()
                  //     .getUserApiOverview(usersListData.id);
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
                  username: usersListData.username,
                ),
              );
            },
          ).toList() ??
          [],
    );
  }

  _showFilterDialog() async {
    // TODO : add filter logic
    // FocusScope.of(context).unfocus();
    // showDialog(
    //   context: context,
    //   barrierDismissible: Constants.falseVal,
    //   barrierColor: ColorManager.black.withOpacity(Constants.zeroDouble),
    //   useSafeArea: Constants.trueVal,
    //   builder: (context) => _filterDialog(context),
    // );
    // if (parentList == Constants.nullValue ||
    //     parentList?.length == Constants.zero) {
    //   await _usersListViewModel.getParentList();
    //   if (profileList == Constants.nullValue ||
    //       profileList?.length == Constants.zero) {
    //     await _usersListViewModel.getProfileList();
    //   }
    // }
    // showFilterWidget = !showFilterWidget;
    // setState(() {});
  }

  // _filterDialog(BuildContext context) {
  //   return Dialog(
  //     insetAnimationCurve: Curves.fastLinearToSlowEaseIn,
  //     insetPadding: const EdgeInsets.only(
  //       top: AppSize.s169,
  //       bottom: AppSize.s55,
  //       left: Constants.zeroDouble,
  //       right: Constants.zeroDouble,
  //     ),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(
  //         AppSize.s0,
  //       ),
  //     ),
  //     backgroundColor: ColorManager.primary,
  //     child: _filterDialogContent(context),
  //   );
  // }

  // _filterDialogContent(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       height: double.infinity,
  //       width: double.infinity,
  //       color: ColorManager.drawerBackground,
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Container(
  //               margin: const EdgeInsets.symmetric(
  //                 horizontal: AppMargin.m16,
  //                 vertical: AppMargin.m12,
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   const SizedBox(width: AppSize.s25),
  //                   Container(
  //                     margin: const EdgeInsets.only(bottom: AppMargin.m6),
  //                     child: Text(
  //                       AppStrings.usersAdvancedFilter,
  //                       style: getMediumStyle(
  //                         color:
  //                             ColorManager.white.withOpacity(AppOpacity.op60),
  //                         fontSize: FontSize.s22,
  //                       ),
  //                     ),
  //                   ),
  //                   IconButton(
  //                     onPressed: () {
  //                       setState(() => showFilterWidget = !showFilterWidget);
  //                       Nav.popRoute(context);
  //                     },
  //                     icon: SvgPicture.asset(
  //                       ImageAssets.clearButton,
  //                       color: ColorManager.white,
  //                       height: AppSize.s20,
  //                       width: AppSize.s20,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             _getParentDropdown(AppStrings.usersParent, context),
  //             const SizedBox(height: AppSize.s12),
  //             _getStatusDropdown(AppStrings.usersStatus, context),
  //             const SizedBox(height: AppSize.s12),
  //             _getConnectionDropdown(AppStrings.usersConnection, context),
  //             const SizedBox(height: AppSize.s12),
  //             _getProfileDropdown(AppStrings.usersProfile, context),
  //             const SizedBox(height: AppSize.s32),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 TextButton(
  //                   style: TextButton.styleFrom(
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: AppPadding.p44,
  //                       vertical: AppPadding.p4,
  //                     ),
  //                   ),
  //                   onPressed: _resetFilters,
  //                   child: const Text(AppStrings.usersReset),
  //                 ),
  //                 const SizedBox(width: AppSize.s75),
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     textStyle: getRegularStyle(
  //                       color: ColorManager.primary,
  //                       fontSize: FontSize.s15,
  //                     ),
  //                     elevation: Constants.zeroDouble,
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: AppPadding.p44,
  //                       vertical: AppPadding.p4,
  //                     ),
  //                   ),
  //                   onPressed: _applyFilters,
  //                   child: const Text(AppStrings.usersApply),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: AppSize.s18),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _resetFilters() {
  //   setState(() {
  //     selectedparent = Constants.nullValue;
  //     selectedprofile = Constants.nullValue;
  //     selectedconnectionFilter = Constants.nullValue;
  //     selectedstatusFilter = Constants.nullValue;
  //     showFilterWidget = !showFilterWidget;
  //     loadFilteredUsers = Constants.trueVal;
  //   });
  //   _searchInputController.clear();
  //   _usersListViewModel.setSearchInput(Constants.empty);
  //   _usersListViewModel.getUserFromSearch();
  //   Nav.popRoute(context);
  // }

  // void _applyFilters() {
  //   setState(() {
  //     showFilterWidget = !showFilterWidget;
  //     loadFilteredUsers = Constants.trueVal;
  //   });
  //   _searchInputController.clear();
  //   _usersListViewModel.setSearchInput(Constants.empty);
  //   _usersListViewModel.getUserFromSearch(
  //     parentId: selectedparent?.id,
  //     profileId: selectedprofile?.id,
  //     connectionId: selectedconnectionFilter?.id,
  //     statusId: selectedstatusFilter?.id,
  //   );
  //   Nav.popRoute(context);
  // }

  // _getParentDropdown(String inputTitle, context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.only(left: AppMargin.m16),
  //         child: Text(
  //           inputTitle,
  //           style: Theme.of(context).textTheme.titleLarge,
  //         ),
  //       ),
  //       SizedBox(
  //         width: MediaQuery.of(context).size.width - AppSize.s20,
  //         child: StreamBuilder<List<SingleParentData>?>(
  //           stream: _usersListViewModel.outputParentList,
  //           builder: (_, snapshot0) {
  //             if (parentList == Constants.nullValue ||
  //                 parentList?.length == Constants.zero) {
  //               parentList = snapshot0.data;
  //             }
  //             debugPrint("parentList: $parentList");
  //             // ignore: prefer_is_empty
  //             return Container(
  //               margin: const EdgeInsets.only(top: AppMargin.m12),
  //               child: DropdownButtonFormField<SingleParentData?>(
  //                 hint: Text(
  //                   AppStrings.usersParentHint,
  //                   style: getRegularStyle(
  //                     color: ColorManager.white.withOpacity(
  //                       AppOpacity.op60,
  //                     ),
  //                     fontSize: FontSize.s16,
  //                   ),
  //                 ),
  //                 iconSize: AppSize.s36,
  //                 menuMaxHeight: AppSize.s300,
  //                 value: selectedparent,
  //                 borderRadius: AppSize.radius25,
  //                 iconDisabledColor: ColorManager.white,
  //                 decoration: InputDecoration(
  //                   border: _filterTextFieldBorderProperties(),
  //                   enabledBorder: _filterTextFieldBorderProperties(),
  //                   focusedBorder: _filterTextFieldBorderProperties(),
  //                   hintStyle: Theme.of(context).textTheme.titleMedium,
  //                   hintText: AppStrings.usersParentHint,
  //                   contentPadding: const EdgeInsets.symmetric(
  //                     horizontal: AppPadding.p20,
  //                   ),
  //                   iconColor: ColorManager.white,
  //                 ),
  //                 iconEnabledColor: ColorManager.white,
  //                 dropdownColor: ColorManager.white,
  //                 elevation: AppSize.s0.toInt(),
  //                 style: Theme.of(context).textTheme.titleMedium,
  //                 selectedItemBuilder: (context) {
  //                   return parentList
  //                           ?.map(
  //                             (e) => SizedBox(
  //                               width: AppSize.s250,
  //                               child: Text(
  //                                 e.username,
  //                                 style:
  //                                     Theme.of(context).textTheme.titleMedium,
  //                                 overflow: TextOverflow.fade,
  //                                 textAlign: TextAlign.left,
  //                               ),
  //                             ),
  //                           )
  //                           .toList() ??
  //                       [];
  //                 },
  //                 onChanged: (singleParentData) {
  //                   selectedparent = singleParentData;
  //                 },
  //                 items: parentList?.map(
  //                   (SingleParentData value) {
  //                     return DropdownMenuItem<SingleParentData>(
  //                       value: value,
  //                       child: Center(
  //                         child: Column(
  //                           children: [
  //                             Card(
  //                               color: ColorManager.transparent,
  //                               elevation: AppSize.s0,
  //                               child: Text(
  //                                 value.username,
  //                                 style: Theme.of(context).textTheme.bodyMedium,
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                             if (parentList?.last != value)
  //                               Divider(
  //                                 color: ColorManager.primary.withOpacity(
  //                                   AppOpacity.op70,
  //                                 ),
  //                                 height: AppSize.s1,
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ).toList(),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // _getStatusDropdown(String inputTitle, context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.only(left: AppMargin.m16),
  //         child: Text(
  //           inputTitle,
  //           style: Theme.of(context).textTheme.titleLarge,
  //         ),
  //       ),
  //       SizedBox(
  //         width: MediaQuery.of(context).size.width - AppSize.s20,
  //         child: StreamBuilder<List<StatusFilterList>?>(
  //           stream: _usersListViewModel.outputStatusList,
  //           builder: (_, snapshot0) {
  //             if (statusFilterList == Constants.nullValue ||
  //                 statusFilterList?.length == Constants.zero) {
  //               statusFilterList = snapshot0.data;
  //             }
  //             // ignore: prefer_is_empty
  //             return Container(
  //               margin: const EdgeInsets.only(top: AppMargin.m12),
  //               child: DropdownButtonFormField<StatusFilterList?>(
  //                 hint: Text(
  //                   AppStrings.usersStatusAny,
  //                   style: getRegularStyle(
  //                     color: ColorManager.white.withOpacity(
  //                       AppOpacity.op60,
  //                     ),
  //                     fontSize: FontSize.s16,
  //                   ),
  //                 ),
  //                 iconSize: AppSize.s36,
  //                 menuMaxHeight: AppSize.s300,
  //                 value: selectedstatusFilter,
  //                 borderRadius: AppSize.radius25,
  //                 iconDisabledColor: ColorManager.white,
  //                 decoration: InputDecoration(
  //                   border: _filterTextFieldBorderProperties(),
  //                   enabledBorder: _filterTextFieldBorderProperties(),
  //                   focusedBorder: _filterTextFieldBorderProperties(),
  //                   contentPadding: const EdgeInsets.symmetric(
  //                     horizontal: AppPadding.p20,
  //                   ),
  //                   iconColor: ColorManager.white,
  //                 ),
  //                 iconEnabledColor: ColorManager.white,
  //                 dropdownColor: ColorManager.white,
  //                 elevation: AppSize.s0.toInt(),
  //                 style: Theme.of(context).textTheme.titleMedium,
  //                 selectedItemBuilder: (context) {
  //                   return statusFilterList
  //                           ?.map(
  //                             (e) => Text(
  //                               e.name,
  //                               style: Theme.of(context).textTheme.titleMedium,
  //                               overflow: TextOverflow.ellipsis,
  //                               textAlign: TextAlign.left,
  //                             ),
  //                           )
  //                           .toList() ??
  //                       [];
  //                 },
  //                 onChanged: (singleStatusData) {
  //                   selectedstatusFilter = singleStatusData;
  //                 },
  //                 items: statusFilterList?.map(
  //                   (StatusFilterList value) {
  //                     return DropdownMenuItem<StatusFilterList>(
  //                       value: value,
  //                       child: Center(
  //                         child: Column(
  //                           children: [
  //                             Card(
  //                               color: ColorManager.transparent,
  //                               elevation: AppSize.s0,
  //                               child: Text(
  //                                 value.name,
  //                                 style: Theme.of(context).textTheme.bodyMedium,
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                             if (statusFilterList?.last != value)
  //                               Divider(
  //                                 color: ColorManager.primary.withOpacity(
  //                                   AppOpacity.op70,
  //                                 ),
  //                                 height: AppSize.s1,
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ).toList(),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // _getConnectionDropdown(String inputTitle, context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.only(left: AppMargin.m16),
  //         child: Text(
  //           inputTitle,
  //           style: Theme.of(context).textTheme.titleLarge,
  //         ),
  //       ),
  //       SizedBox(
  //         width: MediaQuery.of(context).size.width - AppSize.s20,
  //         child: StreamBuilder<List<ConnectionFilterList>?>(
  //           stream: _usersListViewModel.outputConnectionList,
  //           builder: (_, snapshot0) {
  //             if (connectionFilterList == Constants.nullValue ||
  //                 connectionFilterList?.length == Constants.zero) {
  //               connectionFilterList = snapshot0.data;
  //             }
  //             // ignore: prefer_is_empty
  //             return Container(
  //               margin: const EdgeInsets.only(top: AppMargin.m12),
  //               child: DropdownButtonFormField<ConnectionFilterList?>(
  //                 hint: Text(
  //                   AppStrings.usersStatusAny,
  //                   style: getRegularStyle(
  //                     color: ColorManager.white.withOpacity(
  //                       AppOpacity.op60,
  //                     ),
  //                     fontSize: FontSize.s16,
  //                   ),
  //                 ),
  //                 iconSize: AppSize.s36,
  //                 menuMaxHeight: AppSize.s300,
  //                 value: selectedconnectionFilter,
  //                 borderRadius: AppSize.radius25,
  //                 iconDisabledColor: ColorManager.white,
  //                 decoration: InputDecoration(
  //                   border: _filterTextFieldBorderProperties(),
  //                   enabledBorder: _filterTextFieldBorderProperties(),
  //                   focusedBorder: _filterTextFieldBorderProperties(),
  //                   contentPadding: const EdgeInsets.symmetric(
  //                     horizontal: AppPadding.p20,
  //                   ),
  //                   iconColor: ColorManager.white,
  //                 ),
  //                 iconEnabledColor: ColorManager.white,
  //                 dropdownColor: ColorManager.white,
  //                 elevation: AppSize.s0.toInt(),
  //                 style: Theme.of(context).textTheme.titleMedium,
  //                 selectedItemBuilder: (context) {
  //                   return connectionFilterList
  //                           ?.map(
  //                             (e) => Text(
  //                               e.name,
  //                               style: Theme.of(context).textTheme.titleMedium,
  //                               overflow: TextOverflow.ellipsis,
  //                               textAlign: TextAlign.left,
  //                             ),
  //                           )
  //                           .toList() ??
  //                       [];
  //                 },
  //                 onChanged: (singleConnectionData) {
  //                   selectedconnectionFilter = singleConnectionData;
  //                 },
  //                 items: connectionFilterList?.map(
  //                   (ConnectionFilterList value) {
  //                     return DropdownMenuItem<ConnectionFilterList>(
  //                       value: value,
  //                       child: Center(
  //                         child: Column(
  //                           children: [
  //                             Card(
  //                               color: ColorManager.transparent,
  //                               elevation: AppSize.s0,
  //                               child: Text(
  //                                 value.name,
  //                                 style: Theme.of(context).textTheme.bodyMedium,
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                             if (connectionFilterList?.last != value)
  //                               Divider(
  //                                 color: ColorManager.primary.withOpacity(
  //                                   AppOpacity.op70,
  //                                 ),
  //                                 height: AppSize.s1,
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ).toList(),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // _getProfileDropdown(String inputTitle, context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.only(left: AppMargin.m16),
  //         child: Text(
  //           inputTitle,
  //           style: Theme.of(context).textTheme.titleLarge,
  //         ),
  //       ),
  //       SizedBox(
  //         width: MediaQuery.of(context).size.width - AppSize.s20,
  //         child: StreamBuilder<List<ProfileData>>(
  //           stream: _usersListViewModel.outputProfileList,
  //           builder: (_, snapshot0) {
  //             if (profileList == Constants.nullValue ||
  //                 profileList?.length == Constants.zero) {
  //               profileList = snapshot0.data;
  //             }
  //             debugPrint("profileList: $profileList");
  //             // ignore: prefer_is_empty
  //             return Container(
  //               margin: const EdgeInsets.only(top: AppMargin.m12),
  //               child: DropdownButtonFormField<ProfileData>(
  //                 hint: Text(
  //                   AppStrings.usersParentHint,
  //                   style: getRegularStyle(
  //                     color: ColorManager.white.withOpacity(
  //                       AppOpacity.op60,
  //                     ),
  //                     fontSize: FontSize.s16,
  //                   ),
  //                 ),
  //                 iconSize: AppSize.s36,
  //                 menuMaxHeight: AppSize.s300,
  //                 borderRadius: AppSize.radius25,
  //                 value: selectedprofile,
  //                 iconDisabledColor: ColorManager.white,
  //                 decoration: InputDecoration(
  //                   border: _filterTextFieldBorderProperties(),
  //                   enabledBorder: _filterTextFieldBorderProperties(),
  //                   focusedBorder: _filterTextFieldBorderProperties(),
  //                   hintStyle: Theme.of(context).textTheme.titleMedium,
  //                   hintText: AppStrings.usersParentHint,
  //                   contentPadding: const EdgeInsets.symmetric(
  //                     horizontal: AppPadding.p20,
  //                   ),
  //                   iconColor: ColorManager.white,
  //                 ),
  //                 iconEnabledColor: ColorManager.white,
  //                 dropdownColor: ColorManager.white,
  //                 elevation: AppSize.s0.toInt(),
  //                 style: Theme.of(context).textTheme.titleMedium,
  //                 selectedItemBuilder: (context) {
  //                   return profileList
  //                           ?.map(
  //                             (e) => SizedBox(
  //                               width: AppSize.s250,
  //                               child: Text(
  //                                 e.name,
  //                                 style:
  //                                     Theme.of(context).textTheme.titleMedium,
  //                                 overflow: TextOverflow.fade,
  //                                 textAlign: TextAlign.left,
  //                               ),
  //                             ),
  //                           )
  //                           .toList() ??
  //                       [];
  //                 },
  //                 onChanged: (singleProfileData) {
  //                   selectedprofile = singleProfileData;
  //                 },
  //                 items: profileList?.map(
  //                   (ProfileData value) {
  //                     return DropdownMenuItem<ProfileData>(
  //                       value: value,
  //                       child: Center(
  //                         child: Column(
  //                           children: [
  //                             Card(
  //                               color: ColorManager.transparent,
  //                               elevation: AppSize.s0,
  //                               child: Text(
  //                                 value.name,
  //                                 style: Theme.of(context).textTheme.bodyMedium,
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                             if (profileList?.last != value)
  //                               Divider(
  //                                 color: ColorManager.primary.withOpacity(
  //                                   AppOpacity.op70,
  //                                 ),
  //                                 height: AppSize.s1,
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ).toList(),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // _filterTextFieldBorderProperties() {
  //   return OutlineInputBorder(
  //     borderRadius: AppSize.radius10,
  //     borderSide: BorderSide(
  //       color: ColorManager.white,
  //       width: AppSize.s1_5,
  //     ),
  //   );
  // }

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
