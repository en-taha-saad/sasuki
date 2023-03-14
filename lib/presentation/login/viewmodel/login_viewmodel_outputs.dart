abstract class LoginViewModelOutputs {
  // stream controller output
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIs2AuthRequiredValid;
  Stream<bool> get outputIsCaptchaValid;
  Stream<bool> get outputAreAllInputsValid;
  Stream<bool> get outputIsCaptchaEnteredValid;
  Stream<bool> get outputIs2AuthEnteredValid;
}
