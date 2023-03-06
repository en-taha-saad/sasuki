// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managers_list_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagersListResponses _$ManagersListResponsesFromJson(
        Map<String, dynamic> json) =>
    ManagersListResponses(
      json['0'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              SingleManagerDataResponses.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManagersListResponsesToJson(
        ManagersListResponses instance) =>
    <String, dynamic>{
      '0': instance.i0,
      'data': instance.data,
    };

SingleManagerDataResponses _$SingleManagerDataResponsesFromJson(
        Map<String, dynamic> json) =>
    SingleManagerDataResponses(
      json['id'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$SingleManagerDataResponsesToJson(
        SingleManagerDataResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };
