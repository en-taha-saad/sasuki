// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servers_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServersListResponse _$ServersListResponseFromJson(Map<String, dynamic> json) =>
    ServersListResponse(
      (json['servers'] as List<dynamic>?)
          ?.map((e) => ServerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServersListResponseToJson(
        ServersListResponse instance) =>
    <String, dynamic>{
      'servers': instance.servers,
    };

ServerResponse _$ServerResponseFromJson(Map<String, dynamic> json) =>
    ServerResponse(
      json['name'] as String?,
      json['hostname'] as String?,
      json['username'] as String?,
      json['password'] as String?,
    );

Map<String, dynamic> _$ServerResponseToJson(ServerResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'hostname': instance.hostName,
      'username': instance.username,
      'password': instance.password,
    };
