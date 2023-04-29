// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activations_reports_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivationsReportsResponse _$ActivationsReportsResponseFromJson(
        Map<String, dynamic> json) =>
    ActivationsReportsResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ActivationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$ActivationsReportsResponseToJson(
        ActivationsReportsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

ActivationResponse _$ActivationResponseFromJson(Map<String, dynamic> json) =>
    ActivationResponse(
      json['id'] as int?,
      json['price'] as String?,
      json['created_at'] as String?,
      json['user_details'] == null
          ? null
          : UserDetailsResponse.fromJson(
              json['user_details'] as Map<String, dynamic>),
      json['manager_details'] == null
          ? null
          : ManagerDetailsResponse.fromJson(
              json['manager_details'] as Map<String, dynamic>),
      json['profile_details'] == null
          ? null
          : ProfileDetailsResponse.fromJson(
              json['profile_details'] as Map<String, dynamic>),
      json['old_expiration'] as String,
      json['new_expiration'] as String,
      json['activation_method'] as String,
      json['user_activations_count'] as int,
    );

Map<String, dynamic> _$ActivationResponseToJson(ActivationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'created_at': instance.createdAt,
      'user_details': instance.userDetails,
      'manager_details': instance.managerDetails,
      'profile_details': instance.profileDetails,
      'old_expiration': instance.oldExpiration,
      'new_expiration': instance.newExpiration,
      'activation_method': instance.activationMethod,
      'user_activations_count': instance.userActivationsCount,
    };

UserDetailsResponse _$UserDetailsResponseFromJson(Map<String, dynamic> json) =>
    UserDetailsResponse(
      json['id'] as int?,
      json['username'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
    );

Map<String, dynamic> _$UserDetailsResponseToJson(
        UserDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };

ManagerDetailsResponse _$ManagerDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ManagerDetailsResponse(
      json['id'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$ManagerDetailsResponseToJson(
        ManagerDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };

ProfileDetailsResponse _$ProfileDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileDetailsResponse(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$ProfileDetailsResponseToJson(
        ProfileDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
