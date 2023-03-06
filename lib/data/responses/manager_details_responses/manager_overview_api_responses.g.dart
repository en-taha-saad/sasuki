// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_overview_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerOverviewApiResponses _$ManagerOverviewApiResponsesFromJson(
        Map<String, dynamic> json) =>
    ManagerOverviewApiResponses(
      json['data'] == null
          ? null
          : ManagerOverviewDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      json['status'] as int?,
    );

Map<String, dynamic> _$ManagerOverviewApiResponsesToJson(
        ManagerOverviewApiResponses instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

ManagerOverviewDataResponse _$ManagerOverviewDataResponseFromJson(
        Map<String, dynamic> json) =>
    ManagerOverviewDataResponse(
      json['username'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      json['acl_group_name'] as String?,
      json['created_at'] as String?,
      json['balance'] as int?,
      json['reward_points'] as int?,
      json['status'] as int?,
      json['users'] as int?,
      json['active_users'] as int?,
      json['expired_users'] as int?,
      json['phone'] as String?,
      json['parent_username'] as String?,
      json['debts'] as int?,
    );

Map<String, dynamic> _$ManagerOverviewDataResponseToJson(
        ManagerOverviewDataResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'acl_group_name': instance.aclGroupName,
      'created_at': instance.createdAt,
      'balance': instance.balance,
      'reward_points': instance.rewardPoints,
      'status': instance.status,
      'users': instance.users,
      'active_users': instance.activeUsers,
      'expired_users': instance.expiredUsers,
      'phone': instance.phone,
      'parent_username': instance.parentUsername,
      'debts': instance.debts,
    };
