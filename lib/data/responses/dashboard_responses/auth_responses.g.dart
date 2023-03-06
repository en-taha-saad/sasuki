// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponses _$AuthResponsesFromJson(Map<String, dynamic> json) =>
    AuthResponses(
      json['status'] as int?,
      json['client'] == null
          ? null
          : ClientResponse.fromJson(json['client'] as Map<String, dynamic>),
      (json['permissions'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AuthResponsesToJson(AuthResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'client': instance.client,
      'permissions': instance.permissions,
    };

ClientResponse _$ClientResponseFromJson(Map<String, dynamic> json) =>
    ClientResponse(
      json['id'] as int?,
      json['username'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      (json['balance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ClientResponseToJson(ClientResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'balance': instance.balance,
    };
