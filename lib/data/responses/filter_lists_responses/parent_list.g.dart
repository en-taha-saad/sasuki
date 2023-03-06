// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleParentDataResponses _$SingleParentDataResponsesFromJson(
        Map<String, dynamic> json) =>
    SingleParentDataResponses(
      json['id'] as int?,
      json['parent_id'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$SingleParentDataResponsesToJson(
        SingleParentDataResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'username': instance.username,
    };
