// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log_list_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLogListResponses _$ActivityLogListResponsesFromJson(
        Map<String, dynamic> json) =>
    ActivityLogListResponses(
      (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ActivityLogRes.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$ActivityLogListResponsesToJson(
        ActivityLogListResponses instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

ActivityLogRes _$ActivityLogResFromJson(Map<String, dynamic> json) =>
    ActivityLogRes(
      json['id'] as int?,
      json['created_at'] as String?,
      json['created_by'] as int?,
      json['event'] as String?,
      json['description'] as String?,
      json['ip'] as String?,
      json['manager_details'] == null
          ? null
          : ManagerDetailsRes.fromJson(
              json['manager_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityLogResToJson(ActivityLogRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
      'event': instance.event,
      'description': instance.description,
      'ip': instance.ip,
      'manager_details': instance.managerDetails,
    };

ManagerDetailsRes _$ManagerDetailsResFromJson(Map<String, dynamic> json) =>
    ManagerDetailsRes(
      json['id'] as int?,
      json['username'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
    );

Map<String, dynamic> _$ManagerDetailsResToJson(ManagerDetailsRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstname': instance.firstName,
      'lastname': instance.lastName,
    };
