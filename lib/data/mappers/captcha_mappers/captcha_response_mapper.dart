import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/captcha_responses/captcha_responses.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';

extension CaptchaResponseMapper on CaptchaResponses? {
  Captcha toDomain() {
    return Captcha(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.data.toDomain(),
    );
  }
}

extension CaptchaDataResponseMapper on CaptchaDataResponses? {
  CaptchaData toDomain() {
    return CaptchaData(
      this?.requiresCaptcha.orZero() ?? Constants.zeroNum.toInt(),
      this?.siteCurrency.orEmpty() ?? Constants.emptyStr,
    );
  }
}

extension ResponseCaptchaMapper on ResponseCaptcha? {
  DataCaptcha toDomain() {
    return DataCaptcha(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.data.orEmpty() ?? Constants.emptyStr,
    );
  }
}
