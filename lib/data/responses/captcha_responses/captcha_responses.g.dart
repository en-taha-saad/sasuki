// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaResponses _$CaptchaResponsesFromJson(Map<String, dynamic> json) =>
    CaptchaResponses(
      json['status'] as int,
      json['data'] == null
          ? null
          : CaptchaDataResponses.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CaptchaResponsesToJson(CaptchaResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

CaptchaDataResponses _$CaptchaDataResponsesFromJson(
        Map<String, dynamic> json) =>
    CaptchaDataResponses(
      json['site_currency'] as String,
      json['requires_captcha'] as int,
    );

Map<String, dynamic> _$CaptchaDataResponsesToJson(
        CaptchaDataResponses instance) =>
    <String, dynamic>{
      'requires_captcha': instance.requiresCaptcha,
      'site_currency': instance.siteCurrency,
    };

ResponseCaptcha _$ResponseCaptchaFromJson(Map<String, dynamic> json) =>
    ResponseCaptcha(
      json['status'] as int,
      json['data'] as String,
    );

Map<String, dynamic> _$ResponseCaptchaToJson(ResponseCaptcha instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
