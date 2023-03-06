// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'manager_overview_api_responses.g.dart';

@JsonSerializable()
class ManagerOverviewApiResponses {
  @JsonKey(name: 'data')
  ManagerOverviewDataResponse? data;
  @JsonKey(name: 'status')
  int? status;

  ManagerOverviewApiResponses(this.data, this.status);

  Map<String, dynamic> toJson() => _$ManagerOverviewApiResponsesToJson(this);
  factory ManagerOverviewApiResponses.fromJson(Map<String, dynamic> json) =>
      _$ManagerOverviewApiResponsesFromJson(json);
}

@JsonSerializable()
class ManagerOverviewDataResponse {
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'firstname')
  String? firstname;
  @JsonKey(name: 'lastname')
  String? lastname;
  @JsonKey(name: 'acl_group_name')
  String? aclGroupName;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'balance')
  int? balance;
  @JsonKey(name: 'reward_points')
  int? rewardPoints;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'users')
  int? users;
  @JsonKey(name: 'active_users')
  int? activeUsers;
  @JsonKey(name: 'expired_users')
  int? expiredUsers;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'parent_username')
  String? parentUsername;
  @JsonKey(name: 'debts')
  int? debts;

  ManagerOverviewDataResponse(
    this.username,
    this.firstname,
    this.lastname,
    this.aclGroupName,
    this.createdAt,
    this.balance,
    this.rewardPoints,
    this.status,
    this.users,
    this.activeUsers,
    this.expiredUsers,
    this.phone,
    this.parentUsername,
    this.debts,
  );

  Map<String, dynamic> toJson() => _$ManagerOverviewDataResponseToJson(this);
  factory ManagerOverviewDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ManagerOverviewDataResponseFromJson(json);
}
