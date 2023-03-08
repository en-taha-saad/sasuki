import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/models/choosing_server/servers.dart';
import 'package:sasuki/domain/usecase/servers_usecase/remove_server_usecase.dart';
import 'package:sasuki/domain/usecase/servers_usecase/selected_server_usecase.dart';
import 'package:sasuki/domain/usecase/servers_usecase/servers_usecase.dart';
import 'package:sasuki/presentation/choose_server/viewmodel/choose_server_viewmodel_inputs.dart';
import 'package:sasuki/presentation/choose_server/viewmodel/choose_server_viewmodel_outputs.dart';
import 'package:sasuki/presentation//base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/empty_state.dart';

class ChooseServerViewModel extends BaseViewModel
    with ChooseServerViewModelInputs, ChooseServerViewModelOutputs {
  final ChooseServerUseCase _chooseServerUseCase;
  final SelectedServerUsecase _selectedServerUsecase;
  final RemoveServerUsecase _removeServerUsecase;

  final AppPreferences _appPrefs = instance<AppPreferences>();

  ChooseServerViewModel(
    this._chooseServerUseCase,
    this._selectedServerUsecase,
    this._removeServerUsecase,
  );
  @override
  void start() {
    _getServers();
    _getSelectedServer();
  }

  @override
  void dispose() {
    _isSelectedServerStreamController.close();
    _listOfServersStreamController.close();
    _isNotSelectedServerStreamController.close();
    _isNotSelectedServerStreamController.close();
  }

  _getSelectedServer() async {
    // ignore: void_checks
    (await _selectedServerUsecase.execute(Void)).fold(
      (failure) {
        // left -> failure
        inputState.add(ContentState());
        inputSelectedServer.add(null);
        // inputState.add(
        //   ErrorState(
        //     StateRendererType.popupErrorState,
        //     failure.message,
        //   ),
        // );
        debugPrint("failure = ${failure.message}");
      },
      (selectedServer) {
        // right -> success (data)
        debugPrint("success selectedServer = ${selectedServer?.name}");
        inputState.add(ContentState());
        inputSelectedServer.add(selectedServer);
      },
    );
  }

  _getServers() async {
    // ignore: void_checks
    (await _chooseServerUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        inputState.add(EmptyState(AppStrings.servNoServersFound));
        debugPrint("failure = ${failure.message}");
      },
      (serversList) {
        // right -> success (data)
        // ignore: prefer_is_empty
        if (serversList.servers?.length == 0) {
          inputState.add(EmptyState(AppStrings.servNoServersFound));
          return;
        }
        inputState.add(ContentState());
        inputListOfServers.add(serversList);
      },
    );
  }

  removeFromStorageServer(String? serverName) async {
    (await _removeServerUsecase.execute(serverName)).fold(
      (failure) {
        // left -> failure
      },
      (status) {
        // right -> success (data)
      },
    );
  }

  saveSelectedServer(Server? selectedServer) {
    _appPrefs.setSelectedServer(
      ServerResponse(
        selectedServer?.name,
        selectedServer?.hostName,
        "",
        "",
      ),
    );
  }

  ///
  final StreamController _listOfServersStreamController =
      BehaviorSubject<ServersList>();
  @override
  Sink get inputListOfServers => _listOfServersStreamController.sink;
  @override
  Stream<ServersList> get outputGotListOfServers =>
      _listOfServersStreamController.stream.map(
        (listOfServers) => listOfServers,
      );

  ///
  final StreamController _selectedServerStreamController =
      BehaviorSubject<Server?>();
  @override
  Sink get inputSelectedServer => _selectedServerStreamController.sink;
  @override
  Stream<Server?> get outputSelectedServer =>
      _selectedServerStreamController.stream.map(
        (isNotSelected) => isNotSelected,
      );

  ///
  final StreamController _isNotSelectedServerStreamController =
      BehaviorSubject<bool?>();
  @override
  Sink get inputIsNotSelectedServer =>
      _isNotSelectedServerStreamController.sink;
  @override
  Stream<bool?> get outputIsNotSelectedServer =>
      _isNotSelectedServerStreamController.stream.map(
        (isNotSelected) => isNotSelected,
      );

  ///
  final StreamController _isSelectedServerStreamController =
      BehaviorSubject<bool?>();
  @override
  Sink get inputIsSelectedServer => _isSelectedServerStreamController.sink;
  @override
  Stream<bool> get outputIsSelectedServer =>
      _isSelectedServerStreamController.stream.map(
        (isSelectedServer) => isSelectedServer,
      );
}
