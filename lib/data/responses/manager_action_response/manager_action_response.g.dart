// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerActionResponse _$ManagerActionResponseFromJson(
        Map<String, dynamic> json) =>
    ManagerActionResponse(
      json['status'] as int?,
      json['error'] as String?,
    );

Map<String, dynamic> _$ManagerActionResponseToJson(
        ManagerActionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
    };
