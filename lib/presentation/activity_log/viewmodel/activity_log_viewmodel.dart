import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/domain/models/activity_log_list/activity_log_list.dart';
import 'package:sasuki/domain/models/activity_log_events/activity_log_events.dart';
import 'package:sasuki/domain/usecase/activity_log_usecases/activity_log_events_usecase.dart';
import 'package:sasuki/domain/usecase/activity_log_usecases/activity_log_list_usecase.dart';
import 'package:sasuki/presentation/activity_log/viewmodel/activity_log_viewmodel_inputs.dart';
import 'package:sasuki/presentation/activity_log/viewmodel/activity_log_viewmodel_outputs.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';

class ActivityLogViewModel extends BaseViewModel
    with
        ActivityLogViewModelViewModelInputs,
        ActivityLogViewModelViewModelOutputs {
  final ActivityLogEventsUseCase _activityLogEventsUseCase;
  final ActivityLogListUseCase _activityLogListUseCase;

  ActivityLogRequestObject activityLogRequestObject = ActivityLogRequestObject(
    Constants.oneNum.toInt(),
    Constants.twintyNum,
    "created_at",
    "desc",
    Constants.emptyStr,
    Constants.emptyList,
    Constants.minusOne,
    Constants.emptyStr,
  );

  ActivityLogList? activityLogList;
  ActivityLogList? listOfactivityLogs;
  ActivityLogList? emptyListOfActivityLogs;

  ActivityLogViewModel(
    this._activityLogEventsUseCase,
    this._activityLogListUseCase,
  );
  int page = Constants.oneNum.toInt();
  int? totalActivityLogs = 0;

  @override
  Future start() async {
    await getActivityLogListData();
  }

  @override
  void dispose() {}
  @override
  getActivityLogListData() async {
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.activityLogs,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    return (await _activityLogListUseCase.execute(activityLogRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint(
            "failure getActivityLogListData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activityLogList0) async {
        debugPrint(
            "getActivityLogListData failure = ${activityLogList0.total}");
        // right -> success (data)
        activityLogList = activityLogList0;
        inputState.add(ContentState());
        inputActivityLogListData.add(activityLogList);
        totalActivityLogs = activityLogList?.total;
        getActivityLogListDataForPull();
      },
    );
  }

  final StreamController _listOfactivityLogsController =
      StreamController<ActivityLogList?>.broadcast();
  @override
  Sink get inputActivityLogListData => _listOfactivityLogsController.sink;

  @override
  Stream<ActivityLogList> get outputActivityLogListData =>
      _listOfactivityLogsController.stream
          .map((listOfactivityLogs) => listOfactivityLogs);
  resetRequestArguments() {
    page = Constants.oneNum.toInt();
    listOfactivityLogs = null;
    activityLogList = null;
    activityLogRequestObject = activityLogRequestObject.copyWith(page: page);
  }

  @override
  getActivityLogListDataForPull() async {
    resetRequestArguments();
    // ignore: void_checks
    return (await _activityLogListUseCase.execute(activityLogRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint(
            "getActivityLogListDataForPull failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activityLogList0) async {
        debugPrint(
            "getActivityLogListDataForPull failure = ${activityLogList0.total}");
        // right -> success (data)
        activityLogList = activityLogList0;
        listOfactivityLogs = activityLogList;
        inputActivityLogListData.add(activityLogList);
        inputState.add(ContentState());
      },
    );
  }

  @override
  Future refreshActivityLogListData() async {
    activityLogRequestObject =
        activityLogRequestObject.copyWith(page: Constants.oneNum.toInt());
    // ignore: void_checks
    return (await _activityLogListUseCase.execute(activityLogRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("refreshActivityLogListData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activityLogList0) async {
        debugPrint(
            "refreshActivityLogListData failure = ${activityLogList0.total}");
        // right -> success (data)
        activityLogList = activityLogList0;
        listOfactivityLogs = activityLogList;
        inputActivityLogListData.add(activityLogList);
        inputState.add(ContentState());
      },
    );
  }

  @override
  Future getNextActivityLogListData() async {
    page == page++;
    activityLogRequestObject = activityLogRequestObject.copyWith(page: page);
    // ignore: void_checks
    return (await _activityLogListUseCase.execute(activityLogRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getNextActivityLogListData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activityLogList0) async {
        debugPrint(
            "getNextActivityLogListData failure = ${activityLogList0.total}");
        // right -> success (data)
        activityLogList = activityLogList0;
        listOfactivityLogs?.data?.addAll((activityLogList?.data)!);
        inputActivityLogListData.add(listOfactivityLogs);
        totalActivityLogs = activityLogList?.total;
        inputState.add(ContentState());
      },
    );
  }

  @override
  Future getActivityLogFromSearch({String? event}) async {
    inputActivityLogListData.add(emptyListOfActivityLogs);
    activityLogRequestObject = activityLogRequestObject.copyWith(
      page: Constants.oneNum.toInt(),
      event: event ?? Constants.emptyStr,
    );
    debugPrint("event = $event");
    // ignore: void_checks
    return (await _activityLogListUseCase.execute(activityLogRequestObject))
        .fold(
      (failure) {
        // left -> failure
        debugPrint("getActivityLogFromSearch failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activityLogList0) async {
        debugPrint(
            "getActivityLogFromSearch failure = ${activityLogList0.total}");
        // right -> success (data)
        activityLogList = activityLogList0;
        listOfactivityLogs = activityLogList;
        inputActivityLogListData.add(listOfactivityLogs);
        inputState.add(ContentState());
      },
    );
  }

  /// search manager
  final StreamController _searchInputController =
      StreamController<String>.broadcast();
  @override
  Sink get inputSearch => _searchInputController.sink;
  bool _isSearchInputValid(String searchInput) => searchInput.isNotEmpty;
  @override
  Stream<bool> get outputIsSearchInputValid {
    return _searchInputController.stream.map(
      (searchInput) => _isSearchInputValid(searchInput),
    );
  }

  @override
  setSearchInput(String searchInput) {
    inputSearch.add(searchInput);
    activityLogRequestObject =
        activityLogRequestObject.copyWith(search: searchInput);
  }

  ///
  final StreamController _getActivityLogsController =
      StreamController<ActivityLogEvents>.broadcast();
  @override
  Sink get inputActivityLogEvents => _getActivityLogsController.sink;
  @override
  Stream<ActivityLogEvents> get outputActivityLogEvents =>
      _getActivityLogsController.stream
          .map((activityLogEvents) => activityLogEvents);

  @override
  Future getActivityLogEvents() async {
    // ignore: void_checks
    return (await _activityLogEventsUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getActivityLogEvents failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (activityLogEvents0) async {
        debugPrint(
            "getActivityLogEvents failure = ${activityLogEvents0.status}");
        // right -> success (data)
        inputActivityLogEvents.add(activityLogEvents0);
      },
    );
  }
}
