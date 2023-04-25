import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart'
    as managers_list;
import 'package:sasuki/domain/usecase/acl_permission_group_list_usecase/acl_permission_group_list_usecase.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_details_usecase/managers_list_details_usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_usecase/managers_list_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel_inputs.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_viewmodel_outputs.dart';

class ManagersListViewModel extends BaseViewModel
    with ManagersListViewModelInputs, ManagersListViewModelOutputs {
  final ManagersListDetailsUsecase _managersListDetailsUsecase;
  final ManagersListUsecase _managersListUsecase;
  final AclPermissionGroupListUsecase _aclPermissionGroupListUsecase;
  final AuthUseCase _authUseCase;
  final CaptchaUseCase? _captchaUseCase;

  ManagerRequestObject managerRequest = ManagerRequestObject(
    Constants.oneNum.toInt(),
    Constants.twintyNum,
    "username",
    "asc",
    Constants.emptyStr,
    Constants.emptyList,
    Constants.minusOne,
    Constants.oneNum.toInt(),
    Constants.minusOne,
    Constants.minusOne,
    Constants.minusOne,
  );
  ManagerListDetails? managersList;
  ManagerListDetails? listOfManagers;

  ManagersListViewModel(
    this._managersListDetailsUsecase,
    this._managersListUsecase,
    this._aclPermissionGroupListUsecase,
    this._authUseCase,
    this._captchaUseCase,
  );
  int page = Constants.oneNum.toInt();
  Captcha? dataCaptcha;

  @override
  Future start() async {
    await getManagersListData();
  }

  @override
  void dispose() {}

  /// get list of users
  final StreamController _listOfManagersController =
      StreamController<ManagerListDetails?>.broadcast();
  @override
  Sink get inputManagersList => _listOfManagersController.sink;

  @override
  Stream<ManagerListDetails> get outputManagersList =>
      _listOfManagersController.stream.map((listOfManagers) => listOfManagers);

  @override
  getManagersListData() async {
    managerRequest = managerRequest.copyWith(
      page: Constants.oneNum.toInt(),
      columns: Constants.emptyList,
      search: Constants.emptyStr,
      count: Constants.twintyNum,
      groupId: Constants.minusOne,
      parentId: Constants.minusOne,
    );
    _getCaptchaResponse();
    inputState.add(
      LoadingState(
        mobileModuleScreen: MobileModuleScreen.managersList,
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    return (await _managersListDetailsUsecase.execute(managerRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("failure getManagersListData failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managersList0) async {
        debugPrint("getManagersListData failure = ${managersList0.total}");
        _getAuth();

        // right -> success (data)
        managersList = managersList0;
        inputState.add(ContentState());
        inputManagersListData.add(managersList);
        inputManagersList.add(managersList);
        getManagersListForPull();
      },
    );
  }

  @override
  getManagersListForPull() async {
    managerRequest = managerRequest.copyWith(page: Constants.oneNum.toInt());
    // ignore: void_checks
    return (await _managersListDetailsUsecase.execute(managerRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("getManagersListForPull failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managersList0) async {
        // right -> success (data)
        managersList = managersList0;
        listOfManagers = managersList;
        inputManagersListData.add(managersList);
        inputManagersList.add(listOfManagers);
        inputState.add(ContentState());
      },
    );
  }

  @override
  refreshManagersList() async {
    managerRequest = managerRequest.copyWith(page: Constants.oneNum.toInt());
    // ignore: void_checks
    return (await _managersListDetailsUsecase.execute(managerRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("refreshManagersList failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managersList0) async {
        // right -> success (data)
        managersList = managersList0;
        listOfManagers = managersList;
        inputManagersListData.add(managersList);
        inputManagersList.add(listOfManagers);
        inputState.add(ContentState());
      },
    );
  }

  @override
  Future getNextManagersList() async {
    managerRequest = managerRequest.copyWith(page: page++);
    // ignore: void_checks
    return (await _managersListDetailsUsecase.execute(managerRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("getNextManagersList failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managersList0) async {
        // right -> success (data)
        managersList = managersList0;
        listOfManagers?.data?.addAll((managersList?.data)!);
        inputManagersListData.add(managersList);
        inputManagersList.add(listOfManagers);
        debugPrint("users@ listOfUsers = ${listOfManagers?.data?.length}");
        debugPrint("users@ page = $page");
        inputState.add(ContentState());
      },
    );
  }

  ManagerListDetails? emptyListOfManagers;

  @override
  Future getManagerFromSearch({
    int? aclPermissionGroup,
    int? parentId,
  }) async {
    inputManagersList.add(emptyListOfManagers);
    managerRequest = managerRequest.copyWith(
      page: Constants.oneNum.toInt(),
      parentId: parentId ?? Constants.minusOne,
      aclGroupId: aclPermissionGroup ?? Constants.minusOne,
    );
    // ignore: void_checks
    return (await _managersListDetailsUsecase.execute(managerRequest)).fold(
      (failure) {
        // left -> failure
        debugPrint("getManagerFromSearch failure = ${failure.code}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (managersList0) async {
        // right -> success (data)
        managersList = managersList0;
        listOfManagers = managersList0;
        inputManagersList.add(listOfManagers);
        debugPrint(
            "Managers@ listOfManagers = ${listOfManagers?.data?.length}");
        debugPrint("Managers@ page = $page");
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
    managerRequest = managerRequest.copyWith(search: searchInput);
  }

  ///
  final StreamController _getparentManagerListController =
      StreamController<List<managers_list.SingleManagerData>>.broadcast();
  @override
  Sink get inputParentManagerList => _getparentManagerListController.sink;
  @override
  Stream<List<managers_list.SingleManagerData>> get outputParentManagerList =>
      _getparentManagerListController.stream
          .map((parentManagerList) => parentManagerList);

  @override
  Future getParentManagerList() async {
    // ignore: void_checks
    return (await _managersListUsecase.execute(Void)).fold(
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
      (parentManagerList0) async {
        // right -> success (data)
        List<managers_list.SingleManagerData> tempParentManagerList = [];
        tempParentManagerList.add(
          managers_list.SingleManagerData(
            Constants.minusOne,
            "Any",
          ),
        );
        tempParentManagerList.addAll((parentManagerList0.data)!);
        inputParentManagerList.add(tempParentManagerList);
      },
    );
  }

  ///
  final StreamController _getAclPermissionGroupListController =
      StreamController<List<SingleAclPermissionGroup>>.broadcast();
  @override
  Sink get inputAclPermissionGroupList =>
      _getAclPermissionGroupListController.sink;
  @override
  Stream<List<SingleAclPermissionGroup>> get outputAclPermissionGroupList =>
      _getAclPermissionGroupListController.stream
          .map((aclPermissionGroupList) => aclPermissionGroupList);

  @override
  Future getAclPermissionGroupList() async {
    // ignore: void_checks
    return (await _aclPermissionGroupListUsecase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getAclPermissionGroupList failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (aclPermissionGroupList0) async {
        // right -> success (data)
        List<SingleAclPermissionGroup> tempAclPermissionGroupList0 = [];
        tempAclPermissionGroupList0.add(
          SingleAclPermissionGroup(
            Constants.minusOne,
            "Any",
            Constants.minusOne,
          ),
        );
        tempAclPermissionGroupList0.addAll((aclPermissionGroupList0.data)!);
        inputAclPermissionGroupList.add(tempAclPermissionGroupList0);
      },
    );
  }

  ///
  final StreamController _managersListController =
      StreamController<ManagerListDetails>.broadcast();
  @override
  Sink get inputManagersListData => _managersListController.sink;

  @override
  Stream<ManagerListDetails> get outputManagersListData =>
      _managersListController.stream.map(
        (managersList) => managersList,
      );

  bool isThereAddManagerCreationPermission = Constants.falseBool;
  _getAuth() async {
    // ignore: void_checks
    return (await _authUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getAuth failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (auth0) {
        // right -> success (data)
        if (auth0.permissions.contains(AppStrings.managerPermissionCreate)) {
          isThereAddManagerCreationPermission = Constants.trueBool;
        } else {
          isThereAddManagerCreationPermission = Constants.falseBool;
        }
      },
    );
  }

    _getCaptchaResponse() async {
    // ignore: void_checks
    return (await _captchaUseCase?.execute(Void))?.fold(
      (failure) {
        // left -> failure
        debugPrint("failure failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (Captcha dataCaptcha0) {
        // right -> success (data)
        dataCaptcha = dataCaptcha0;
        inputDataCaptcha.add(dataCaptcha);
      },
    );
  }

  final StreamController _captchaController =
      StreamController<Captcha>.broadcast();

  Sink get inputDataCaptcha => _captchaController.sink;
  Stream<Captcha> get outputDataCaptcha => _captchaController.stream.map(
        (captcha) => captcha,
      );

}
