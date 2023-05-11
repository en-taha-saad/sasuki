import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/usecase/add_user_usecase/add_user_usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/parent_list.usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/presentation/add_user/viewmodel/add_user_viewmodel_inputs.dart';
import 'package:sasuki/presentation/add_user/viewmodel/add_user_viewmodel_outputs.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/users_list/viewmodel/users_list_viewmodel.dart';

class AddUserViewModel extends BaseViewModel
    with AddUserViewModelInputs, AddUserViewModelOutputs {
  final AddUserUseCase _addUserUseCase;
  final ProfileListUseCase _profileListUseCase;
  final ParentListUseCase _parentListUseCase;
  final UsersListViewModel _usersListViewModel = instance<UsersListViewModel>();

  AddUserViewModel(
    this._addUserUseCase,
    this._profileListUseCase,
    this._parentListUseCase,
  );

  AddUserRequestObject addUserRequestObject = AddUserRequestObject(
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.zeroNum.toInt(),
  );

  @override
  void start() {
    getProfileList();
    getParentList();
  }

  @override
  void dispose() {
    _areAllInputsValidStreamController.close();
    _passwordController.close();
    _userNameController.close();
    _getProfileListController.close();
    _getParentListController.close();
    super.dispose();
  }

  @override
  addUser() async {
    addUserRequestObject = addUserRequestObject.copyWith(
      parentId: addUserRequestObject.parentId,
      profileId: addUserRequestObject.profileId,
      enabled: Constants.oneNum.toInt(),
    );
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    return (await _addUserUseCase.execute(addUserRequestObject)).fold(
      (failure) {
        // left -> failure
        debugPrint("addUser failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (userAction) async {
        // right -> success (data)
        debugPrint("userAction = $userAction");
        _usersListViewModel.refreshUsersList();
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.userAddedSuccess,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  saveFloatingButton(
    bool? enteredInputs,
    SingleParentData? selectedparent,
    ProfileData? selectedprofile,
  ) {
    if (enteredInputs == Constants.trueBool &&
        selectedparent != Constants.nullValue &&
        selectedprofile != Constants.nullValue) {
      addUserRequestObject = addUserRequestObject.copyWith(
        parentId: selectedparent!.id,
        profileId: selectedprofile!.id,
      );
      addUser();
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
    addUserRequestObject = addUserRequestObject.copyWith(username: username);
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    addUserRequestObject = addUserRequestObject.copyWith(
      password: password,
      confirmPassword: password,
    );
    inputAreAllInputsValid.add(Constants.falseBool);
  }

  @override
  void setFirstName(String firstName) {
    addUserRequestObject = addUserRequestObject.copyWith(firstname: firstName);
  }

  @override
  void setLastName(String lastName) {
    addUserRequestObject = addUserRequestObject.copyWith(lastname: lastName);
  }

  @override
  void setPhone(String phone) {
    addUserRequestObject = addUserRequestObject.copyWith(phone: phone);
  }

  @override
  void setNotes(String notes) {
    addUserRequestObject = addUserRequestObject.copyWith(notes: notes);
  }

  ///
  final StreamController _areAllInputsValidStreamController =
      StreamController<bool>.broadcast();
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  bool _areAllInputsValid() =>
      _isUsernameValid(addUserRequestObject.username!) &&
      _isPasswordValid(addUserRequestObject.password!);
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
        debugPrint("getProfileList = ${profileList0.data.length}");
        profileList.addAll(profileList0.data);
        inputProfileList.add(profileList);
      },
    );
  }

  ///
  final StreamController _getProfileListController =
      StreamController<List<ProfileData>>.broadcast();
  @override
  Sink get inputProfileList => _getProfileListController.sink;
  @override
  Stream<List<ProfileData>> get outputProfileList =>
      _getProfileListController.stream.map((profileList) => profileList);

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
        debugPrint("getParentList failure = ${failure.message}");
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
        tempParentList.addAll(parentList0);
        inputParentList.add(tempParentList);
      },
    );
  }
}
