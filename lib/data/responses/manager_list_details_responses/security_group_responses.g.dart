// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_group_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityGroupResponses _$SecurityGroupResponsesFromJson(
        Map<String, dynamic> json) =>
    SecurityGroupResponses(
      (json['data'] as List<dynamic>?)
          ?.map((e) => SingleACLResponses.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as int?,
    );

Map<String, dynamic> _$SecurityGroupResponsesToJson(
        SecurityGroupResponses instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

SingleACLResponses _$SingleACLResponsesFromJson(Map<String, dynamic> json) =>
    SingleACLResponses(
      json['id'] as int?,
      json['name'] as String?,
      json['dashboard_id'] as int?,
    );

Map<String, dynamic> _$SingleACLResponsesToJson(SingleACLResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dashboard_id': instance.dashboardId,
    };
