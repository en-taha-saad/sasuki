// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiResponse _$UserApiResponseFromJson(Map<String, dynamic> json) =>
    UserApiResponse(
      json['data'] == null
          ? null
          : UserDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )..status = json['status'] as int?;

Map<String, dynamic> _$UserApiResponseToJson(UserApiResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      json['id'] as int?,
      json['username'] as String?,
      json['profile_id'] as int?,
      json['enabled'] as int?,
      json['expiration'] as String?,
      json['address'] as String?,
      json['city'] as String?,
      json['country'] as String?,
      json['mac_auth'] as int?,
      json['static_ip'] as String?,
      json['group_id'] as int?,
      json['service'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['company'] as String?,
      json['apartment'] as String?,
      json['street'] as String?,
      json['contract_id'] as int?,
      json['parent_id'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_at'] as String?,
      json['last_ip_address'] as String?,
      json['last_online'] as String?,
      json['user_type'] as int?,
      json['created_by'] as String?,
      json['national_id'] as int?,
      json['simultaneous_sessions'] as int?,
      json['mikrotik_winbox_group'] as String?,
      json['mikrotik_framed_route'] as String?,
      json['mikrotik_addresslist'] as String?,
      json['mikrotik_ipv6_prefix'] as String?,
      json['balance'] as String?,
      json['loan_balance'] as String?,
      json['notes'] as String?,
      json['picture'] as String?,
      json['pin_tries'] as int?,
      json['site_id'] as int?,
      json['gps_lat'] as String?,
      json['gps_lng'] as String?,
      json['last_Profile_id'] as int?,
      json['auto_renew'] as int?,
      json['use_separate_portal_password'] as int?,
      json['restricted'] as int?,
      json['profile_name'] as String?,
      json['status'] == null
          ? null
          : UserDataStatusResponse.fromJson(
              json['status'] as Map<String, dynamic>),
      json['profile_change'] as bool?,
      json['parent_username'] as String?,
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profile_id': instance.profileId,
      'enabled': instance.enabled,
      'expiration': instance.expiration,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'mac_auth': instance.macAuth,
      'static_ip': instance.staticIp,
      'group_id': instance.groupId,
      'service': instance.service,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'company': instance.company,
      'apartment': instance.apartment,
      'street': instance.street,
      'contract_id': instance.contractId,
      'parent_id': instance.parentId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'last_ip_address': instance.lastIpAddress,
      'last_online': instance.lastOnline,
      'user_type': instance.userType,
      'created_by': instance.createdBy,
      'national_id': instance.nationalId,
      'simultaneous_sessions': instance.simultaneousSessions,
      'mikrotik_winbox_group': instance.mikrotikWinboxGroup,
      'mikrotik_framed_route': instance.mikrotikFramedRoute,
      'mikrotik_addresslist': instance.mikrotikAddresslist,
      'mikrotik_ipv6_prefix': instance.mikrotikIpv6Prefix,
      'balance': instance.balance,
      'loan_balance': instance.loanBalance,
      'notes': instance.notes,
      'picture': instance.picture,
      'pin_tries': instance.pinTries,
      'site_id': instance.siteId,
      'gps_lat': instance.gpsLat,
      'gps_lng': instance.gpsLng,
      'last_Profile_id': instance.lastProfileId,
      'auto_renew': instance.autoRenew,
      'use_separate_portal_password': instance.useSeparatePortalPassword,
      'restricted': instance.restricted,
      'profile_name': instance.profileName,
      'status': instance.status,
      'profile_change': instance.profileChange,
      'parent_username': instance.parentUsername,
    };

UserDataStatusResponse _$UserDataStatusResponseFromJson(
        Map<String, dynamic> json) =>
    UserDataStatusResponse(
      json['status'] as bool?,
      json['traffic'] as bool?,
      json['expiration'] as bool?,
      json['uptime'] as bool?,
    );

Map<String, dynamic> _$UserDataStatusResponseToJson(
        UserDataStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'traffic': instance.traffic,
      'expiration': instance.expiration,
      'uptime': instance.uptime,
    };
