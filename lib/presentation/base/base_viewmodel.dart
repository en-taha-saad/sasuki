import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sasuki/presentation/base/base_viewmodel_outputs.dart';
import 'package:sasuki/presentation/base/base_viewmodel_inputs.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and function that will be used through any view model.
  final StreamController _inputStreamController = BehaviorSubject<FlowState>();
  @override
  void dispose() {
    // _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map(
        (flowState) => flowState,
      );
}
