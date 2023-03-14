// inputs mean that "Orders" that our view model will receive from view
abstract class LoginViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  setCaptcha(String captcha);
  set2Auth(String twoAuth);
  login();
  isRequiredCaptcha();
  getCaptcha();

  // stream controller input
  Sink get inputUsername;
  Sink get inputCaptcha;
  Sink get input2Auth;
  Sink get inputPassword;
  Sink get inputIsCaptchaEnteredValid;
  Sink get inputIs2AuthRequiredValid;
  Sink get inputAreAllInputsValid;
}
