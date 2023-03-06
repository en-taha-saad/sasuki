// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activation_informs_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivationInformsResponse _$ActivationInformsResponseFromJson(
        Map<String, dynamic> json) =>
    ActivationInformsResponse(
      json['data'] == null
          ? null
          : ActivationInformsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      json['status'] as int?,
    );

Map<String, dynamic> _$ActivationInformsResponseToJson(
        ActivationInformsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

ActivationInformsDataResponse _$ActivationInformsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ActivationInformsDataResponse(
      json['manager_balance'] as String?,
      json['user_balance'] as String?,
      json['unit_price'] as String?,
      (json['user_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ActivationInformsDataResponseToJson(
        ActivationInformsDataResponse instance) =>
    <String, dynamic>{
      'manager_balance': instance.managerBalance,
      'user_balance': instance.userBalance,
      'unit_price': instance.unitPrice,
      'user_price': instance.userPrice,
    };
