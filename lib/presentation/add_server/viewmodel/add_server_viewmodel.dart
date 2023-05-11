import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/usecase/servers_usecase/add_server_usecase.dart';
import 'package:sasuki/presentation/add_server/viewmodel/add_server_viewmodel_inputs.dart';
import 'package:sasuki/presentation/add_server/viewmodel/add_server_viewmodel_outputs.dart';
import 'package:sasuki/presentation//base/base_viewmodel.dart';

class AddServerViewModel extends BaseViewModel
    with AddServerViewModelInputs, AddServerViewModelOutputs {
  AddServerViewModel(this._addServerUseCase);
  final AddServerUseCase _addServerUseCase;

  final server = Server("", "", "", "");
  @override
  void start() {}

  @override
  void dispose() {
    _ispNameStreamController.close();
    _hostNameController.close();
    _areAllInputsValidStreamController.close();
    super.dispose();
  }

  addServer() async {
    (await _addServerUseCase.execute(server)).fold(
      (failure) {
        // left -> failure
      },
      (status) {
        // right -> success (data)
      },
    );
  }

  ///
  final _ispNameStreamController = BehaviorSubject<String>();
  @override
  Sink get inputIspName => _ispNameStreamController.sink;
  bool _isIspNameValid(String username) => username.isNotEmpty;
  @override
  Stream<bool> get outputIsIspNameValid {
    return _ispNameStreamController.stream.map(
      (ispName) => _isIspNameValid(ispName),
    );
  }

  ///
  final _hostNameController = BehaviorSubject<String>();
  @override
  Sink get inputHostName => _hostNameController.sink;
  bool _isHostNameValid(String hostName) => RegExp(
        AppStrings.hostNameRegex,
      ).hasMatch(hostName);
  @override
  Stream<bool> get outputIsServerAddressValid {
    return _hostNameController.stream.map(
      (serverAddress) => _isHostNameValid(serverAddress),
    );
  }

  ///
  final _areAllInputsValidStreamController = BehaviorSubject<void>();
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  bool _areAllInputsValid() =>
      _isIspNameValid(server.name) && _isHostNameValid(server.hostName);
  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream.map(
        (_) => _areAllInputsValid(),
      );

  ///
  @override
  setIspName(String ispName) {
    inputIspName.add(ispName);
    inputAreAllInputsValid.add(null);
    server.name = ispName;
  }

  @override
  setHostName(String hostName) {
    inputHostName.add(hostName);
    inputAreAllInputsValid.add(null);
    server.hostName = hostName;
  }
}
