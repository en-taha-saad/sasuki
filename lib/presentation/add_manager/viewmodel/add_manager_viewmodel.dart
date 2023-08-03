import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/usecase/acl_permission_group_list_usecase/acl_permission_group_list_usecase.dart';
import 'package:sasuki/domain/usecase/add_manager_usecase/add_manager_usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_usecase/managers_list_usecase.dart';
import 'package:sasuki/presentation/add_manager/viewmodel/add_manager_viewmodel_inputs.dart';
import 'package:sasuki/presentation/add_manager/viewmodel/add_user_viewmodel_outputs.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart'
    as managers_list;

class AddManagerViewModel extends BaseViewModel
    with AddManagerViewModelInputs, AddManagerViewModelOutputs {
  final AddManagerUseCase _addManagerUseCase;
  final ManagersListUsecase _managersListUsecase;
  final AclPermissionGroupListUsecase _aclPermissionGroupListUsecase;

  AddManagerViewModel(
    this._addManagerUseCase,
    this._managersListUsecase,
    this._aclPermissionGroupListUsecase,
  );

  AddEditManagerRequestObject addManagerRequestObject =
      AddEditManagerRequestObject(
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
  );

  @override
  void start() {
    getParentManagerList();
    getAclPermissionGroupList();
  }

  @override
  void dispose() {}

  @override
  addManager() async {
    addManagerRequestObject = addManagerRequestObject.copyWith(
      parentId: addManagerRequestObject.parentId,
      aclGroupId: addManagerRequestObject.aclGroupId,
      enabled: Constants.oneNum.toInt(),
    );
    debugPrint("addManagerRequestObject = $addManagerRequestObject");
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    return (await _addManagerUseCase.execute(addManagerRequestObject)).fold(
      (failure) {
        // left -> failure
        debugPrint("addManager failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (addManager) async {
        // right -> success (data)
        debugPrint("addManager = ${addManager.status}");
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.managerAddedSuccess,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s100.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  saveFloatingButton(
    bool? enteredInputs,
    managers_list.SingleManagerData? selectedParentManager,
    SingleAclPermissionGroup? singleAclPermissionGroup,
  ) {
    if (enteredInputs == Constants.trueBool &&
        selectedParentManager != Constants.nullValue &&
        singleAclPermissionGroup != Constants.nullValue) {
      addManagerRequestObject = addManagerRequestObject.copyWith(
        parentId: selectedParentManager!.id,
        aclGroupId: singleAclPermissionGroup!.id,
      );
      addManager();
    } else {
      if (!enteredInputs!) {
        inputUsername.add(Constants.emptyStr);
        inputPassword.add(Constants.emptyStr);
      }
    }
  }

  @override
  void setUsername(String username) {
    inputUsername.add(username);
    addManagerRequestObject =
        addManagerRequestObject.copyWith(username: username);
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    addManagerRequestObject = addManagerRequestObject.copyWith(
      password: password,
      confirmPassword: password,
    );
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  @override
  void setFirstName(String firstName) {
    inputFirstName.add(firstName);
    addManagerRequestObject =
        addManagerRequestObject.copyWith(firstname: firstName);
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  @override
  void setLastName(String lastName) {
    inputLastName.add(lastName);
    addManagerRequestObject =
        addManagerRequestObject.copyWith(lastname: lastName);
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  @override
  void setPhone(String phone) {
    addManagerRequestObject = addManagerRequestObject.copyWith(phone: phone);
  }

  @override
  void setNotes(String notes) {
    addManagerRequestObject = addManagerRequestObject.copyWith(notes: notes);
  }

  @override
  void setCompany(String company) {
    addManagerRequestObject =
        addManagerRequestObject.copyWith(company: company);
  }

  @override
  void setEmail(String email) {
    addManagerRequestObject = addManagerRequestObject.copyWith(email: email);
  }

  @override
  void setCity(String city) {
    addManagerRequestObject = addManagerRequestObject.copyWith(city: city);
  }

  @override
  void setAddress(String address) {
    addManagerRequestObject =
        addManagerRequestObject.copyWith(address: address);
  }

  ///
  final StreamController _areAllInputsValidStreamController =
      StreamController<bool>.broadcast();
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  bool _areAllInputsValid() =>
      _isUsernameValid(addManagerRequestObject.username!) &&
      _isPasswordValid(addManagerRequestObject.password!) &&
      _isFirstNameValid(addManagerRequestObject.firstname!) &&
      _isLastNameValid(addManagerRequestObject.lastname!);
  @override
  Stream<bool> get outputAreAllInputsValid {
    return _areAllInputsValidStreamController.stream.map(
      (_) => _areAllInputsValid(),
    );
  }

  ///
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  @override
  Sink get inputPassword => _passwordController.sink;
  bool _isPasswordValid(String password) => password.isNotEmpty;
  @override
  Stream<bool> get outputIsPasswordValid {
    return _passwordController.stream.map(
      (password) => _isPasswordValid(password),
    );
  }

  ///
  final StreamController _userNameController =
      StreamController<String>.broadcast();
  @override
  Sink get inputUsername => _userNameController.sink;
  bool _isUsernameValid(String username) => username.isNotEmpty;
  @override
  Stream<bool> get outputIsUsernameValid {
    return _userNameController.stream.map(
      (userName) => _isUsernameValid(userName),
    );
  }

  final StreamController _firstNameController =
      StreamController<String>.broadcast();
  @override
  Sink get inputFirstName => _firstNameController.sink;
  bool _isFirstNameValid(String firstName) => firstName.isNotEmpty;
  @override
  Stream<bool> get outputIsFirstNameValid {
    return _firstNameController.stream.map(
      (firstName) => _isFirstNameValid(firstName),
    );
  }

  final StreamController _lastNameController =
      StreamController<String>.broadcast();
  @override
  Sink get inputLastName => _lastNameController.sink;
  bool _isLastNameValid(String lastName) => lastName.isNotEmpty;
  @override
  Stream<bool> get outputIsLastNameValid {
    return _lastNameController.stream.map(
      (lastName) => _isLastNameValid(lastName),
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
        List<SingleAclPermissionGroup> aclPermissionGroupList = [];
        debugPrint(
            "getAclPermissionGroupList = ${aclPermissionGroupList0.data?.length}");
        aclPermissionGroupList.addAll((aclPermissionGroupList0.data)!);
        inputAclPermissionGroupList.add(aclPermissionGroupList);
      },
    );
  }

  ///
  final StreamController _getParentManagerListController =
      StreamController<List<managers_list.SingleManagerData>>.broadcast();
  @override
  Sink get inputParentManagerList => _getParentManagerListController.sink;
  @override
  Stream<List<managers_list.SingleManagerData>> get outputParentManagerList =>
      _getParentManagerListController.stream
          .map((parentManagerList) => parentManagerList);
  @override
  Future getParentManagerList() async {
    // ignore: void_checks
    return (await _managersListUsecase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getParentManagerList failure = ${failure.message}");
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
        tempParentManagerList.addAll((parentManagerList0.data)!);
        inputParentManagerList.add(tempParentManagerList);
      },
    );
  }
}
