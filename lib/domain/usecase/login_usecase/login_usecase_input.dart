class LoginUseCaseInput {
  late String username;
  late String password;
  late String language;
  late String otp;
  late String captchaText;
  late String sessionId;

  LoginUseCaseInput(
    this.username,
    this.password,
    this.language,
    this.otp,
    this.captchaText,
    this.sessionId,
  );
  LoginUseCaseInput.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    language = json['language'];
    otp = json['otp'];
    captchaText = json['captchaText'];
    sessionId = json['sessionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['language'] = language;
    data['otp'] = otp;
    data['captchaText'] = captchaText;
    data['sessionId'] = sessionId;
    return data;
  }
}
