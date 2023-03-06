// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'captcha_responses.g.dart';

@JsonSerializable()
class CaptchaResponses {
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'data')
  CaptchaDataResponses? data;

  CaptchaResponses(this.status, this.data);
  factory CaptchaResponses.fromJson(Map<String, dynamic> json) =>
      _$CaptchaResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$CaptchaResponsesToJson(this);
}

@JsonSerializable()
class CaptchaDataResponses {
  @JsonKey(name: 'requires_captcha')
  int requiresCaptcha;
  @JsonKey(name: 'site_currency')
  String siteCurrency;

  CaptchaDataResponses(this.siteCurrency, this.requiresCaptcha);
  factory CaptchaDataResponses.fromJson(Map<String, dynamic> json) =>
      _$CaptchaDataResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$CaptchaDataResponsesToJson(this);
}

@JsonSerializable()
class ResponseCaptcha {
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'data')
  String data;

  ResponseCaptcha(this.status, this.data);
  factory ResponseCaptcha.fromJson(Map<String, dynamic> json) =>
      _$ResponseCaptchaFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseCaptchaToJson(this);
}
