// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowed_extersion_methods_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowedExtersionMethodsResponses _$AllowedExtersionMethodsResponsesFromJson(
        Map<String, dynamic> json) =>
    AllowedExtersionMethodsResponses(
      json['i0'] as int?,
      json['status'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => ExtensionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllowedExtersionMethodsResponsesToJson(
        AllowedExtersionMethodsResponses instance) =>
    <String, dynamic>{
      'i0': instance.i0,
      'status': instance.status,
      'data': instance.data,
    };

ExtensionResponse _$ExtensionResponseFromJson(Map<String, dynamic> json) =>
    ExtensionResponse(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$ExtensionResponseToJson(ExtensionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
