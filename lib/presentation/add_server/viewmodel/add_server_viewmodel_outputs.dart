abstract class AddServerViewModelOutputs {
  // stream controller output
  Stream<bool> get outputIsIspNameValid;
  Stream<bool> get outputIsServerAddressValid;
  Stream<bool> get outputAreAllInputsValid;
}
