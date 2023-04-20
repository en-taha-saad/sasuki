// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_details_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerDetailsResponses _$ManagerDetailsResponsesFromJson(
        Map<String, dynamic> json) =>
    ManagerDetailsResponses(
      json['status'] as int?,
      json['data'] == null
          ? null
          : ManagerDetailsDataResponses.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManagerDetailsResponsesToJson(
        ManagerDetailsResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

ManagerDetailsDataResponses _$ManagerDetailsDataResponsesFromJson(
        Map<String, dynamic> json) =>
    ManagerDetailsDataResponses(
      json['id'] as int?,
      json['username'] as String?,
      json['enabled'] as int?,
      json['city'] as String?,
      json['country'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['company'] as String?,
      json['address'] as String?,
      json['balance'] as int?,
      json['notes'] as String?,
      json['managerId'] as int?,
      json['maxUsers'] as int?,
      json['createdAt'] as String?,
      json['deletedAt'] as String?,
      json['aclGroupId'] as int?,
      json['parentId'] as int?,
      json['createdBy'] as int?,
    );

Map<String, dynamic> _$ManagerDetailsDataResponsesToJson(
        ManagerDetailsDataResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'enabled': instance.enabled,
      'city': instance.city,
      'country': instance.country,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'company': instance.company,
      'address': instance.address,
      'balance': instance.balance,
      'notes': instance.notes,
      'managerId': instance.managerId,
      'maxUsers': instance.maxUsers,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'aclGroupId': instance.aclGroupId,
      'parentId': instance.parentId,
      'createdBy': instance.createdBy,
    };
