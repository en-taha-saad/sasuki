class LoginRequest {
  String username;
  String password;
  String language;
  String otp;
  String captchaText;
  String sessionId;

  LoginRequest(
    this.username,
    this.password,
    this.language,
    this.otp,
    this.captchaText,
    this.sessionId,
  );
}
