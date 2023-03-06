// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'user_api_responses.g.dart';

@JsonSerializable()
class UserApiResponse {
  @JsonKey(name: 'data')
  UserDataResponse? data;
  @JsonKey(name: 'status')
  int? status;

  UserApiResponse(this.data);
  Map<String, dynamic> toJson() => _$UserApiResponseToJson(this);
  factory UserApiResponse.fromJson(Map<String, dynamic> json) =>
      _$UserApiResponseFromJson(json);
}

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "profile_id")
  int? profileId;
  @JsonKey(name: "enabled")
  int? enabled;
  @JsonKey(name: "expiration")
  String? expiration;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "mac_auth")
  int? macAuth;
  @JsonKey(name: "static_ip")
  String? staticIp;
  @JsonKey(name: "group_id")
  int? groupId;
  @JsonKey(name: "service")
  String? service;
  @JsonKey(name: "firstname")
  String? firstname;
  @JsonKey(name: "lastname")
  String? lastname;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "company")
  String? company;
  @JsonKey(name: "apartment")
  String? apartment;
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "contract_id")
  int? contractId;
  @JsonKey(name: "parent_id")
  int? parentId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  String? deletedAt;
  @JsonKey(name: "last_ip_address")
  String? lastIpAddress;
  @JsonKey(name: "last_online")
  String? lastOnline;
  @JsonKey(name: "user_type")
  int? userType;
  @JsonKey(name: "created_by")
  String? createdBy;
  @JsonKey(name: "national_id")
  int? nationalId;
  @JsonKey(name: "simultaneous_sessions")
  int? simultaneousSessions;
  @JsonKey(name: "mikrotik_winbox_group")
  String? mikrotikWinboxGroup;
  @JsonKey(name: "mikrotik_framed_route")
  String? mikrotikFramedRoute;
  @JsonKey(name: "mikrotik_addresslist")
  String? mikrotikAddresslist;
  @JsonKey(name: "mikrotik_ipv6_prefix")
  String? mikrotikIpv6Prefix;
  @JsonKey(name: "balance")
  String? balance;
  @JsonKey(name: "loan_balance")
  String? loanBalance;
  @JsonKey(name: "notes")
  String? notes;
  @JsonKey(name: "picture")
  String? picture;
  @JsonKey(name: "pin_tries")
  int? pinTries;
  @JsonKey(name: "site_id")
  int? siteId;
  @JsonKey(name: "gps_lat")
  String? gpsLat;
  @JsonKey(name: "gps_lng")
  String? gpsLng;
  @JsonKey(name: "last_Profile_id")
  int? lastProfileId;
  @JsonKey(name: "auto_renew")
  int? autoRenew;
  @JsonKey(name: "use_separate_portal_password")
  int? useSeparatePortalPassword;
  @JsonKey(name: "restricted")
  int? restricted;
  @JsonKey(name: "profile_name")
  String? profileName;
  @JsonKey(name: "status")
  UserDataStatusResponse? status;
  @JsonKey(name: "profile_change")
  bool? profileChange;
  @JsonKey(name: "parent_username")
  String? parentUsername;

  UserDataResponse(
    this.id,
    this.username,
    this.profileId,
    this.enabled,
    this.expiration,
    this.address,
    this.city,
    this.country,
    this.macAuth,
    this.staticIp,
    this.groupId,
    this.service,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.company,
    this.apartment,
    this.street,
    this.contractId,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lastIpAddress,
    this.lastOnline,
    this.userType,
    this.createdBy,
    this.nationalId,
    this.simultaneousSessions,
    this.mikrotikWinboxGroup,
    this.mikrotikFramedRoute,
    this.mikrotikAddresslist,
    this.mikrotikIpv6Prefix,
    this.balance,
    this.loanBalance,
    this.notes,
    this.picture,
    this.pinTries,
    this.siteId,
    this.gpsLat,
    this.gpsLng,
    this.lastProfileId,
    this.autoRenew,
    this.useSeparatePortalPassword,
    this.restricted,
    this.profileName,
    this.status,
    this.profileChange,
    this.parentUsername,
  );
  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);
}

@JsonSerializable()
class UserDataStatusResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "traffic")
  bool? traffic;
  @JsonKey(name: "expiration")
  bool? expiration;
  @JsonKey(name: "uptime")
  bool? uptime;

  UserDataStatusResponse(
    this.status,
    this.traffic,
    this.expiration,
    this.uptime,
  );
  Map<String, dynamic> toJson() => _$UserDataStatusResponseToJson(this);
  factory UserDataStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataStatusResponseFromJson(json);
}
