// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_list_details_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerListDetailsResponses _$ManagerListDetailsResponsesFromJson(
        Map<String, dynamic> json) =>
    ManagerListDetailsResponses(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              SingleManagerDetailsResponses.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$ManagerListDetailsResponsesToJson(
        ManagerListDetailsResponses instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

SingleManagerDetailsResponses _$SingleManagerDetailsResponsesFromJson(
        Map<String, dynamic> json) =>
    SingleManagerDetailsResponses(
      json['id'] as int?,
      json['username'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      (json['balance'] as num?)?.toDouble(),
      json['enabled'] as int?,
      json['users_count'] as int?,
      json['acl_group_details'] == null
          ? null
          : AclGroupDetailsResponses.fromJson(
              json['acl_group_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleManagerDetailsResponsesToJson(
        SingleManagerDetailsResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'balance': instance.balance,
      'enabled': instance.enabled,
      'users_count': instance.userCount,
      'acl_group_details': instance.aclGroupDetails,
    };

AclGroupDetailsResponses _$AclGroupDetailsResponsesFromJson(
        Map<String, dynamic> json) =>
    AclGroupDetailsResponses(
      json['id'] as int?,
      json['name'] as String?,
      json['dashboard_id'] as int?,
    );

Map<String, dynamic> _$AclGroupDetailsResponsesToJson(
        AclGroupDetailsResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dashboard_id': instance.dashboardId,
    };
