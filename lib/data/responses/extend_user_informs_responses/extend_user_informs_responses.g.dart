// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extend_user_informs_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendUserInformsResponses _$ExtendUserInformsResponsesFromJson(
        Map<String, dynamic> json) =>
    ExtendUserInformsResponses(
      json['status'] as int?,
      json['data'] == null
          ? null
          : ExtendUserResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtendUserInformsResponsesToJson(
        ExtendUserInformsResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

ExtendUserResponse _$ExtendUserResponseFromJson(Map<String, dynamic> json) =>
    ExtendUserResponse(
      json['expiration'] as String?,
      json['profile_name'] as String?,
      json['username'] as String?,
      json['balance'] as String?,
      json['user_balance'] as String?,
      json['reward_points'] as int?,
    );

Map<String, dynamic> _$ExtendUserResponseToJson(ExtendUserResponse instance) =>
    <String, dynamic>{
      'expiration': instance.expiration,
      'profile_name': instance.profileName,
      'username': instance.username,
      'balance': instance.balance,
      'user_balance': instance.userBalance,
      'reward_points': instance.rewardPoints,
    };
