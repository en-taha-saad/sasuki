// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileListResponses _$ProfileListResponsesFromJson(
        Map<String, dynamic> json) =>
    ProfileListResponses(
      json['i0'] as int?,
      json['status'] as int?,
      (json['data'] as List<dynamic>)
          .map((e) => ProfileDataResponses.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileListResponsesToJson(
        ProfileListResponses instance) =>
    <String, dynamic>{
      'i0': instance.i0,
      'status': instance.status,
      'data': instance.data,
    };

ProfileDataResponses _$ProfileDataResponsesFromJson(
        Map<String, dynamic> json) =>
    ProfileDataResponses(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$ProfileDataResponsesToJson(
        ProfileDataResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
