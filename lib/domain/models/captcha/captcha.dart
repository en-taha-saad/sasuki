class Captcha {
  int status;
  CaptchaData? data;

  Captcha(this.status, this.data);
}

class CaptchaData {
  int requiresCaptcha;
  String siteCurrency;

  CaptchaData(
    this.requiresCaptcha,
    this.siteCurrency,
  );
}

class DataCaptcha {
  int status;
  String data;

  DataCaptcha(this.status, this.data);
}
