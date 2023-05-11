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
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/single_manager_card.dart';
import 'package:sasuki/app/shared_widgets/single_manager_card_statistics.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/manager_details/viewmodel/manager_details_viewmodel.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel.dart';
import 'package:intl/intl.dart' as intl;

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
  List<SingleAclPermissionGroup>? aclPermissionGroupList;
  SingleAclPermissionGroup? selectedAclPermissionGroup;

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
      } else {
        setState(() {
          loadingMoreManagers = Constants.trueBool;
        });
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
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                top: AppPadding.p4,
                              ),
                              child: InkWell(
                                child: SvgPicture.asset(IconsAssets.menu),
                                onTap: () {
                                  Nav.navTo(context, Routes.drawerRoute);
                                },
                              ),
                            ),
                            Container(),
                          ],
                        ),
                        Center(
                          child: Text(
                            AppStrings.managersListScreen,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 18,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    StreamBuilder<ManagerListDetails?>(
                      stream: _managersListViewModel.outputManagersList,
                      builder: (context, snapshot) {
                        return SingleManagerCardStatistics(
                          isShimmer: Constants.falseBool,
                          totalManagers:
                              "${snapshot.data?.total ?? Constants.dash}",
                        );
                      },
                    ),
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
              _managersListViewModel.isThereAddManagerCreationPermission
                  ? InkWell(
                      onTap: () {
                        Nav.navTo(context, Routes.addManagerRoute);
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
                    )
                  : Container(),
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
                color: ColorManager.whiteNeutral,
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
    setState(() => loadFilteredManagers = Constants.falseBool);
    _managersListViewModel.getManagerFromSearch();
  }

  Widget _getManagersList() {
    return StreamBuilder<ManagerListDetails?>(
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
                    ColorManager.orangeAnnotations,
                  ),
                ),
              );
      },
    );
  }

  Widget _singleManager(
      List<SingleManagerDetails>? listOfManagers, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfManagers?.map(
            (managersListData) {
              return InkWell(
                onTap: () {
                  Nav.navTo(context, Routes.managerDetailsRoute);
                  instance<ManagerDetailsViewModel>()
                      .getManagerApiOverview(managersListData.id!);
                },
                child: SingleManagerCard(
                  fullName: managersListData.firstname != Constants.nullValue ||
                          managersListData.lastname != ""
                      ? "${managersListData.firstname} ${managersListData.lastname}"
                      : Constants.dash,
                  permissionGroup: managersListData.aclGroupDetails?.name !=
                              Constants.nullValue ||
                          managersListData.aclGroupDetails?.name != ""
                      ? "${managersListData.aclGroupDetails?.name}"
                      : Constants.dash,
                  balance: managersListData.balance != Constants.nullValue ||
                          // ignore: unrelated_type_equality_checks
                          managersListData.balance != ""
                      ? "${_managersListViewModel.dataCaptcha?.data?.siteCurrency} ${intl.NumberFormat.decimalPattern().format(managersListData.balance)}"
                      : Constants.dash,
                  status: _getUserStatusString(managersListData),
                  statusColor: _getUserStatusColor(managersListData),
                  usersCount: managersListData.usersCount != Constants.nullValue
                      ? "${managersListData.usersCount}"
                      : Constants.dash,
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
    if (parentManagerList == Constants.nullValue ||
        parentManagerList?.length == Constants.zeroDouble) {
      await _managersListViewModel.getParentManagerList();

      ///
      if (aclPermissionGroupList == Constants.nullValue ||
          aclPermissionGroupList?.length == Constants.zeroDouble) {
        await _managersListViewModel.getAclPermissionGroupList();
      }
    }
    showFilterWidget = !showFilterWidget;
    setState(() {});
  }

  _filterDialog(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.fastLinearToSlowEaseIn,
      insetPadding: EdgeInsets.only(
        left: Constants.zeroDouble,
        right: Constants.zeroDouble,
        top: MediaQuery.of(context).size.height * 0.1,
        bottom: MediaQuery.of(context).size.height * 0.4,
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
        decoration: BoxDecoration(
          color: const Color(0xff2D3B60),
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
            // TOOD: uncomment this when parrent list is ready
            _getParentManagerDropdown(AppStrings.usersParent, context),
            _getAclPermissionGroupDropdown(
                AppStrings.managerPermission, context),
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
      selectedparentManager = Constants.nullValue;
      showFilterWidget = !showFilterWidget;
      loadFilteredManagers = Constants.trueBool;
    });
    _searchInputController.clear();
    _managersListViewModel.setSearchInput(Constants.emptyStr);
    _managersListViewModel.getManagerFromSearch();
    Nav.popRoute(context);
  }

  void _applyFilters() {
    setState(() {
      showFilterWidget = !showFilterWidget;
      loadFilteredManagers = Constants.trueBool;
    });
    _searchInputController.clear();
    _managersListViewModel.setSearchInput(Constants.emptyStr);
    _managersListViewModel.getManagerFromSearch(
      parentId: selectedparentManager?.id,
      aclPermissionGroup: selectedAclPermissionGroup?.id,
    );
    Nav.popRoute(context);
  }

  _getParentManagerDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s20),
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        StreamBuilder<List<SingleManagerData>?>(
          stream: _managersListViewModel.outputParentManagerList,
          builder: (_, snapshot0) {
            if (parentManagerList == Constants.nullValue ||
                parentManagerList?.length == Constants.zeroNum) {
              parentManagerList = snapshot0.data;
            }
            debugPrint("parentManagerList: $parentManagerList");
            // ignore: prefer_is_empty
            return Container(
              margin: const EdgeInsets.only(top: AppMargin.m15),
              child: DropDownComponent<SingleManagerData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersParentHint,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x26ffffff),
                    width: 1.0,
                  ),
                  borderRadius: RadiusSizes.radius12,
                ),
                items: parentManagerList ?? [],
                doOtherThings: (val) {
                  selectedparentManager = val;
                },
                displayFn: (item) => (item as SingleManagerData).username ?? "",
                textAndHintColor: ColorManager.whiteNeutral,
              ),
            );
          },
        ),
      ],
    );
  }

  _getAclPermissionGroupDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s15),
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        StreamBuilder<List<SingleAclPermissionGroup>?>(
          stream: _managersListViewModel.outputAclPermissionGroupList,
          builder: (_, snapshot0) {
            if (aclPermissionGroupList == Constants.nullValue ||
                aclPermissionGroupList?.length == Constants.zeroNum) {
              aclPermissionGroupList = snapshot0.data;
            }
            debugPrint("aclPermissionGroupList: $aclPermissionGroupList");
            // ignore: prefer_is_empty
            return Container(
              margin: const EdgeInsets.only(top: AppMargin.m15),
              child: DropDownComponent<SingleAclPermissionGroup?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.managersAclPermissionHint,
                items: aclPermissionGroupList ?? [],
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x26ffffff),
                    width: 1.0,
                  ),
                  borderRadius: RadiusSizes.radius12,
                ),
                doOtherThings: (val) {
                  selectedAclPermissionGroup = val;
                },
                displayFn: (item) =>
                    (item as SingleAclPermissionGroup).name ?? "",
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
        ? ColorManager.orangeAnnotations
        : ColorManager.greenAnnotations;
  }
}
