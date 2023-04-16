import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/domain/models/filter_lists/connection_list.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/filter_lists/status_list.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/parent_list.usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_usecase/managers_list_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel_inputs.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel_outputs.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_viewmodel_outputs.dart';

class ManagersListViewModel extends BaseViewModel
    with ManagersListViewModelInputs, ManagersListViewModelOutputs {
  final ManagersListUsecase _managersListUsecase;
  UserRequestObject userRequest = UserRequestObject(
    Constants.oneNum.toInt(),
    Constants.twintyNum,
    "username",
    "asc",
    Constants.emptyStr,
    Constants.emptyList,
    Constants.minusOne,
    Constants.minusOne,
    Constants.minusOne,
    Constants.minusOne,
    Constants.minusOne,
    Constants.minusOne,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
  );
  UsersList? usersList;
  List<UsersListData>? listOfUsers;

  ManagersListViewModel(this._managersListUsecase);
  int page = Constants.oneNum.toInt();
  @override
  Future start() async {
    await getManagersListData();
  }

  @override
  void dispose() {}

  ///
  final StreamController _usersListController =
      StreamController<UsersList>.broadcast();
  @override
  Sink get inputUsersListData => _usersListController.sink;

  @override
  Stream<UsersList> get outputUsersListData => _usersListController.stream.map(
        (usersList) => usersList,
      );

  @override
  getManagersListData() async {
    userRequest = userRequest.copyWith(
      page: Constants.oneNum.toInt(),
      columns: Constants.emptyList,
      status: Constants.minusOne,
      connection: Constants.minusOne,
      search: Constants.emptyStr,
      count: Constants.twintyNum,
      groupId: Constants.minusOne,
      parentId: Constants.minusOne,
      profileId: Constants.minusOne,
    );
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.usersList,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    return (await _managersListUsecase.execute(userRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("failure getUsersListData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (usersList0) async {
        debugPrint("getUsersListData failure = ${usersList0.total}");

        // right -> success (data)
        usersList = usersList0;
        inputState.add(ContentState());
        inputUsersListData.add(usersList);
        inputUsersList.add(usersList?.data);
        getUsersListForPull();
      },
    );
  }

  @override
  getManagersListForPull([void Function()? dashboardRequestsStart]) async {
    userRequest = userRequest.copyWith(page: Constants.oneNum.toInt());
    // ignore: void_checks
    return (await _managersListUsecase.execute(userRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("getUsersListForPull failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (usersList0) async {
        // right -> success (data)
        usersList = usersList0;
        listOfUsers = usersList?.data;
        inputUsersListData.add(usersList);
        inputUsersList.add(listOfUsers);
        if (dashboardRequestsStart != null) {
          dashboardRequestsStart();
        }
        inputState.add(ContentState());
      },
    );
  }

  @override
  refreshManagersList() async {
    userRequest = userRequest.copyWith(page: Constants.oneNum.toInt());
    // ignore: void_checks
    return (await _managersListUsecase.execute(userRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("getUsersListForPull failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (usersList0) async {
        // right -> success (data)
        usersList = usersList0;
        listOfUsers = usersList?.data;
        inputUsersListData.add(usersList);
        inputUsersList.add(listOfUsers);
        inputState.add(ContentState());
      },
    );
  }

  @override
  Future getNextManagersList() async {
    userRequest = userRequest.copyWith(page: page++);
    // ignore: void_checks
    return (await _managersListUsecase.execute(userRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("getNextUsersList failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (usersList0) async {
        // right -> success (data)
        usersList = usersList0;
        listOfUsers?.addAll((usersList?.data)!);
        inputUsersListData.add(usersList);
        inputUsersList.add(listOfUsers);
        debugPrint("users@ listOfUsers = ${listOfUsers?.length}");
        debugPrint("users@ page = $page");
        inputState.add(ContentState());
      },
    );
  }

  List<UsersListData>? emptyListOfUsers = [];

  @override
  Future getManagerFromSearch({
    int? profileId,
    int? parentId,
    int? statusId,
    int? connectionId,
  }) async {
    inputUsersList.add(emptyListOfUsers);
    userRequest = userRequest.copyWith(
      page: Constants.oneNum.toInt(),
      profileId: profileId ?? Constants.minusOne,
      parentId: parentId ?? Constants.minusOne,
      status: statusId ?? Constants.minusOne,
      connection: connectionId ?? Constants.minusOne,
    );
    // ignore: void_checks
    return (await _managersListUsecase.execute(userRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("getUserFromSearch failure = ${failure.code}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (usersList0) async {
        // right -> success (data)
        usersList = usersList0;
        listOfUsers = usersList0.data;
        inputUsersList.add(listOfUsers);
        debugPrint("users@ listOfUsers = ${listOfUsers?.length}");
        debugPrint("users@ page = $page");
        inputState.add(ContentState());
      },
    );
  }

  /// get list of users
  final StreamController _listOfUsersController =
      StreamController<List<UsersListData>?>.broadcast();
  @override
  Sink get inputManagersList => _listOfUsersController.sink;

  @override
  Stream<ManagerListDetails> get outputManagersList =>
      _listOfUsersController.stream.map((listOfUsers) => listOfUsers);

  /// search user
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
    userRequest = userRequest.copyWith(search: searchInput);
  }

  ///
  final StreamController _getParentListController =
      StreamController<List<SingleParentData>>.broadcast();
  @override
  Sink get inputParentList => _getParentListController.sink;
  @override
  Stream<List<SingleParentData>> get outputParentList =>
      _getParentListController.stream.map((parentList) => parentList);
  @override
  Future getParentList() async {
    // ignore: void_checks
    return (await _parentListUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getUsersListData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (parentList0) async {
        // right -> success (data)
        List<SingleParentData> tempParentList = [];
        tempParentList.add(
          SingleParentData(
            Constants.minusOne,
            parentList0[Constants.zeroNum.toInt()].parentId,
            "Any",
          ),
        );
        tempParentList.addAll(parentList0);
        inputParentList.add(tempParentList);
        inputStatusList.add(listOfStatus);
        inputConnectionList.add(listOfConnection);
      },
    );
  }

  ///
  final StreamController _getStatusListController =
      StreamController<List<StatusFilterList>>.broadcast();
  @override
  Sink get inputStatusList => _getStatusListController.sink;
  @override
  Stream<List<StatusFilterList>> get outputStatusList =>
      _getStatusListController.stream.map((statusList) => statusList);

  ///
  final StreamController _getConnectionListController =
      StreamController<List<ConnectionFilterList>>.broadcast();
  @override
  Sink get inputConnectionList => _getConnectionListController.sink;
  @override
  Stream<List<ConnectionFilterList>> get outputConnectionList =>
      _getConnectionListController.stream
          .map((connectionList) => connectionList);

  ///
  final StreamController _getProfileListController =
      StreamController<List<ProfileData>>.broadcast();
  @override
  Sink get inputProfileList => _getProfileListController.sink;
  @override
  Stream<List<ProfileData>> get outputProfileList =>
      _getProfileListController.stream.map((profileList) => profileList);
  @override
  Future getProfileList() async {
    // ignore: void_checks
    return (await _profileListUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getProfileList failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (profileList0) async {
        // right -> success (data)
        List<ProfileData> profileList = [];
        profileList.add(
          ProfileData(Constants.minusOne, "Any"),
        );
        debugPrint("getProfileList = ${profileList0.data.length}");
        profileList.addAll(profileList0.data);
        inputProfileList.add(profileList);
      },
    );
  }
}
