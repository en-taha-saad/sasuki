// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'user_overview_api_responses.g.dart';

@JsonSerializable()
class UserOverviewApiResponse {
  @JsonKey(name: 'data')
  UserOverviewDataResponse? data;
  @JsonKey(name: 'status')
  int? status;

  UserOverviewApiResponse(this.data, this.status);

  Map<String, dynamic> toJson() => _$UserOverviewApiResponseToJson(this);
  factory UserOverviewApiResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOverviewApiResponseFromJson(json);
}

@JsonSerializable()
class UserOverviewDataResponse {
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "parent_username")
  String? parentUsername;
  @JsonKey(name: "profile_name")
  String? profileName;
  @JsonKey(name: "profile_id")
  int? profileId;
  @JsonKey(name: "expiration")
  String? expiration;
  @JsonKey(name: "status")
  bool? status;
  // @JsonKey(name: "created_at")
  // String? createdAt;
  // @JsonKey(name: "created_by")
  // String? createdBy;
  // @JsonKey(name: "balance")
  // int? balance;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "firstname")
  String? firstname;
  @JsonKey(name: "lastname")
  String? lastname;
  @JsonKey(name: "phone")
  String? phone;
  // @JsonKey(name: "address")
  // String? address;
  // @JsonKey(name: "city")
  // String? city;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "remaining_rx")
  int? remainingRx;
  @JsonKey(name: "remaining_tx")
  int? remainingTx;
  @JsonKey(name: "remaining_rxtx")
  int? remainingRxtx;
  @JsonKey(name: "remaining_uptime")
  int? remainingUptime;
  // @JsonKey(name: "next_profile_change")
  // bool? nextProfileChange;
  // @JsonKey(name: "pin_tries")
  // int? pinTries;
  @JsonKey(name: "last_online")
  String? lastOnline;
  // @JsonKey(name: "addons")
  // List<String>? addons;

  UserOverviewDataResponse(
    this.username,
    this.parentUsername,
    this.profileName,
    this.profileId,
    this.expiration,
    this.status,
    // this.createdAt,
    // this.createdBy,
    // this.balance,
    this.password,
    this.firstname,
    this.lastname,
    this.phone,
    // this.address,
    // this.city,
    this.email,
    this.remainingRx,
    this.remainingTx,
    this.remainingRxtx,
    this.remainingUptime,
    // this.nextProfileChange,
    // this.pinTries,
    this.lastOnline,
    // this.addons,
  );
  Map<String, dynamic> toJson() => _$UserOverviewDataResponseToJson(this);
  factory UserOverviewDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOverviewDataResponseFromJson(json);
}
