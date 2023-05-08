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
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/single_activity_log_card.dart';
import 'package:sasuki/domain/models/activity_log_events/activity_log_events.dart';
import 'package:sasuki/domain/models/activity_log_list/activity_log_list.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/presentation/activity_log/viewmodel/activity_log_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';

class ActivityLogView extends StatefulWidget {
  const ActivityLogView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ActivityLogViewState createState() => _ActivityLogViewState();
}

class _ActivityLogViewState extends State<ActivityLogView> {
  final ActivityLogViewModel _activityLogViewModel =
      instance<ActivityLogViewModel>();
  final ScrollController _scrollController = ScrollController();
  final _searchInputController = TextEditingController();
  bool loadingMoreActivityLogs = Constants.falseBool;
  bool loadFilteredActivityLogs = Constants.falseBool;
  bool showFilterWidget = Constants.falseBool;
  List<SingleManagerData>? activityLogEventsList;
  List<ActivityLogEvent>? activityLogEvents;
  ActivityLogEvent? selectedActivityLogEvent;

  _bind() async {
    await _activityLogViewModel.start();
    _handleNext();
    _searchInputController.addListener(
      () {
        _activityLogViewModel.setSearchInput(_searchInputController.text);
      },
    );
  }

  @override
  void dispose() {
    _activityLogViewModel.dispose();
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
          loadingMoreActivityLogs = Constants.trueBool;
        });
        _activityLogViewModel.getNextActivityLogListData();
        if (_scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loadingMoreActivityLogs = Constants.falseBool;
          });
        }
      } else {
        setState(() {
          loadingMoreActivityLogs = Constants.trueBool;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _activityLogViewModel.outputState,
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
      onRefresh: () async => _activityLogViewModel.refreshActivityLogListData(),
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
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff1B2A52),
      ),
      child: Column(
        children: [
          Container(
            color: ColorManager.primaryshade1,
            child: Column(
              children: [
                AppSize.statusBarHeight(context),
                const SizedBox(height: AppSize.s20),
                Container(
                  margin: const EdgeInsets.only(
                    left: AppPadding.p25,
                    right: AppPadding.p25,
                    bottom: AppPadding.p20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSize.s10),
                            child: InkWell(
                              child: SvgPicture.asset(IconsAssets.back),
                              onTap: () {
                                Nav.popRoute(context);
                              },
                            ),
                          ),
                          Text(
                            AppStrings.drawerActivityLog,
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
                  width: getScreenWidth(context) * 0.8,
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
              ],
            ),
          ),
          const SizedBox(height: AppSize.s15),
          Expanded(
            child: _getActivityLogsList(),
          ),
        ],
      ),
    );
  }

  bool showClearIcon = Constants.falseBool;
  _getSearchTextField() {
    return Stack(
      children: [
        TextFormField(
          controller: _searchInputController,
          onEditingComplete: _searchActivityLogs,
          onTap: () {
            setState(() {
              showClearIcon = Constants.trueBool;
            });
          },
          onFieldSubmitted: (value) {
            _searchActivityLogs();
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
                    _searchActivityLogs();
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

  _searchActivityLogs() {
    FocusScope.of(context).unfocus();
    setState(() => loadFilteredActivityLogs = Constants.falseBool);
    _activityLogViewModel.getActivityLogFromSearch();
  }

  Widget _getActivityLogsList() {
    return StreamBuilder<ActivityLogList?>(
      stream: _activityLogViewModel.outputActivityLogListData,
      builder: (context, snapshot) {
        // ignore: prefer_is_empty
        if (snapshot.data?.data?.length == Constants.oneNum ||
            snapshot.data?.data?.length == Constants.zeroNum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(
              Duration(seconds: Constants.oneNum.toInt()),
              () => setState(
                  () => loadFilteredActivityLogs = Constants.falseBool),
            );
          });
        }
        return !loadFilteredActivityLogs
            // ignore: prefer_is_empty
            ? snapshot.data?.data?.length != Constants.zeroNum
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: loadingMoreActivityLogs
                        ? Column(
                            children: [
                              _singleActivityLog(snapshot.data?.data, context),
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
                        : _singleActivityLog(snapshot.data?.data, context),
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
                              setState(() => loadFilteredActivityLogs = true);
                              _activityLogViewModel
                                  .refreshActivityLogListData();
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

  Widget _singleActivityLog(
      List<ActivityLog?>? listOfActivityLogs, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfActivityLogs?.map(
            (activityLog) {
              return SingleActivityLog(activityLog: activityLog);
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
    if (activityLogEvents == Constants.nullValue ||
        activityLogEvents?.length == Constants.zeroDouble) {
      await _activityLogViewModel.getActivityLogEvents();
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
            _getEventsDropdown(AppStrings.eventFilter, context),
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
      selectedActivityLogEvent = Constants.nullValue;
      showFilterWidget = !showFilterWidget;
      loadFilteredActivityLogs = Constants.trueBool;
    });
    _searchInputController.clear();
    _activityLogViewModel.setSearchInput(Constants.emptyStr);
    _activityLogViewModel.getActivityLogFromSearch();
    Nav.popRoute(context);
  }

  void _applyFilters() {
    setState(() {
      showFilterWidget = !showFilterWidget;
      loadFilteredActivityLogs = Constants.trueBool;
    });
    _searchInputController.clear();
    _activityLogViewModel.setSearchInput(Constants.emptyStr);
    _activityLogViewModel.getActivityLogFromSearch(
      event: selectedActivityLogEvent?.event,
    );
    Nav.popRoute(context);
  }

  _getEventsDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s20),
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        StreamBuilder<ActivityLogEvents>(
          stream: _activityLogViewModel.outputActivityLogEvents,
          builder: (_, snapshot0) {
            if (activityLogEvents == Constants.nullValue ||
                activityLogEvents?.length == Constants.zeroNum) {
              activityLogEvents = snapshot0.data?.data;
            }
            debugPrint("activityLogEvents: $activityLogEvents");
            // ignore: prefer_is_empty
            return Container(
              margin: const EdgeInsets.only(top: AppMargin.m15),
              child: DropDownComponent<ActivityLogEvent?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.allEventsHint,
                items: activityLogEvents ?? [],
                doOtherThings: (val) {
                  selectedActivityLogEvent = val;
                },
                displayFn: (item) => (item as ActivityLogEvent).event ?? "",
                textAndHintColor: ColorManager.whiteNeutral,
              ),
            );
          },
        ),
      ],
    );
  }
}
