// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paydebt_informs_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaydebtInformsResponses _$PaydebtInformsResponsesFromJson(
        Map<String, dynamic> json) =>
    PaydebtInformsResponses(
      json['status'] as int?,
      json['data'] == null
          ? null
          : PaydebtDataResponses.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaydebtInformsResponsesToJson(
        PaydebtInformsResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

PaydebtDataResponses _$PaydebtDataResponsesFromJson(
        Map<String, dynamic> json) =>
    PaydebtDataResponses(
      json['total'] as int?,
      json['debt_for_me'] as int?,
    );

Map<String, dynamic> _$PaydebtDataResponsesToJson(
        PaydebtDataResponses instance) =>
    <String, dynamic>{
      'total': instance.total,
      'debt_for_me': instance.debtForMe,
    };
