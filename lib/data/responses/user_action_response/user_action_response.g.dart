// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActionResponse _$UserActionResponseFromJson(Map<String, dynamic> json) =>
    UserActionResponse(
      json['status'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$UserActionResponseToJson(UserActionResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };

EditUserResponse _$EditUserResponseFromJson(Map<String, dynamic> json) =>
    EditUserResponse(
      json['status'] as int?,
    );

Map<String, dynamic> _$EditUserResponseToJson(EditUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
    };
