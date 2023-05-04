// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_methods_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodsResponses _$PaymentMethodsResponsesFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodsResponses(
      json['status'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              SinglePaymentMethodResponses.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentMethodsResponsesToJson(
        PaymentMethodsResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

SinglePaymentMethodResponses _$SinglePaymentMethodResponsesFromJson(
        Map<String, dynamic> json) =>
    SinglePaymentMethodResponses(
      json['id'] as int?,
      json['name'] as String?,
      json['country'] as String?,
      json['internalName'] as String?,
    );

Map<String, dynamic> _$SinglePaymentMethodResponsesToJson(
        SinglePaymentMethodResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'internalName': instance.internalName,
    };
