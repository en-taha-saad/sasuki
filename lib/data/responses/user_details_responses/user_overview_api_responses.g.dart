// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_overview_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOverviewApiResponse _$UserOverviewApiResponseFromJson(
        Map<String, dynamic> json) =>
    UserOverviewApiResponse(
      json['data'] == null
          ? null
          : UserOverviewDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      json['status'] as int?,
    );

Map<String, dynamic> _$UserOverviewApiResponseToJson(
        UserOverviewApiResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

UserOverviewDataResponse _$UserOverviewDataResponseFromJson(
        Map<String, dynamic> json) =>
    UserOverviewDataResponse(
      json['username'] as String?,
      json['parent_username'] as String?,
      json['profile_name'] as String?,
      json['profile_id'] as int?,
      json['expiration'] as String?,
      json['status'] as bool?,
      json['password'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['remaining_rx'] as int?,
      json['remaining_tx'] as int?,
      json['remaining_rxtx'] as int?,
      json['remaining_uptime'] as int?,
      json['last_online'] as String?,
    )..balance = json['balance'] as int?;

Map<String, dynamic> _$UserOverviewDataResponseToJson(
        UserOverviewDataResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'parent_username': instance.parentUsername,
      'profile_name': instance.profileName,
      'profile_id': instance.profileId,
      'expiration': instance.expiration,
      'status': instance.status,
      'balance': instance.balance,
      'password': instance.password,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone': instance.phone,
      'email': instance.email,
      'remaining_rx': instance.remainingRx,
      'remaining_tx': instance.remainingTx,
      'remaining_rxtx': instance.remainingRxtx,
      'remaining_uptime': instance.remainingUptime,
      'last_online': instance.lastOnline,
    };
