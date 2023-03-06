// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersListResponse _$UsersListResponseFromJson(Map<String, dynamic> json) =>
    UsersListResponse(
      (json['data'] as List<dynamic>?)
          ?.map(
              (e) => UsersListDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$UsersListResponseToJson(UsersListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

UsersListDataResponse _$UsersListDataResponseFromJson(
        Map<String, dynamic> json) =>
    UsersListDataResponse(
      json['id'] as int?,
      json['username'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      json['expiration'] as String?,
      json['enabled'] as int?,
      json['notes'] as String?,
      json['status'] == null
          ? null
          : StatusResponses.fromJson(json['status'] as Map<String, dynamic>),
      json['online_status'] as int?,
      json['profile_details'] == null
          ? null
          : ProfileDetailsResponses.fromJson(
              json['profile_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersListDataResponseToJson(
        UsersListDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'expiration': instance.expiration,
      'enabled': instance.enabled,
      'notes': instance.notes,
      'status': instance.status,
      'online_status': instance.onlineStatus,
      'profile_details': instance.profileDetails,
    };

StatusResponses _$StatusResponsesFromJson(Map<String, dynamic> json) =>
    StatusResponses(
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$StatusResponsesToJson(StatusResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

ProfileDetailsResponses _$ProfileDetailsResponsesFromJson(
        Map<String, dynamic> json) =>
    ProfileDetailsResponses(
      json['id'] as int?,
      json['name'] as String?,
      json['type'] as int?,
    );

Map<String, dynamic> _$ProfileDetailsResponsesToJson(
        ProfileDetailsResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };

GroupDetailsResponses _$GroupDetailsResponsesFromJson(
        Map<String, dynamic> json) =>
    GroupDetailsResponses(
      json['id'] as int?,
      json['group_name'] as String?,
    );

Map<String, dynamic> _$GroupDetailsResponsesToJson(
        GroupDetailsResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_name': instance.groupName,
    };
