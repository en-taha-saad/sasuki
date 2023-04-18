// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acl_permission_group_list_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AclPermissionGroupListResponses _$AclPermissionGroupListResponsesFromJson(
        Map<String, dynamic> json) =>
    AclPermissionGroupListResponses(
      json['status'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SingleAclPermissionGroupResponses.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AclPermissionGroupListResponsesToJson(
        AclPermissionGroupListResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

SingleAclPermissionGroupResponses _$SingleAclPermissionGroupResponsesFromJson(
        Map<String, dynamic> json) =>
    SingleAclPermissionGroupResponses(
      json['id'] as int?,
      json['name'] as String?,
      json['dashboard_id'] as int?,
    );

Map<String, dynamic> _$SingleAclPermissionGroupResponsesToJson(
        SingleAclPermissionGroupResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dashboard_id': instance.dashboardId,
    };
