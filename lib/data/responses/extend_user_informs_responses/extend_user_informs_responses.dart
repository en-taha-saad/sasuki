// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'extend_user_informs_responses.g.dart';

@JsonSerializable()
class ExtendUserInformsResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  ExtendUserResponse? data;

  ExtendUserInformsResponses(this.status, this.data);
  factory ExtendUserInformsResponses.fromJson(Map<String, dynamic> json) =>
      _$ExtendUserInformsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ExtendUserInformsResponsesToJson(this);
}

@JsonSerializable()
class ExtendUserResponse {
  // @JsonKey(name: 'remaining_rxtx')
  // String? remainingRxtx;
  // @JsonKey(name: 'remaining_rx')
  // String? remainingRx;
  // @JsonKey(name: 'remaining_tx')
  // String? remainingTx;
  // @JsonKey(name: 'remaining_uptime')
  // String? remainingUptime;
  @JsonKey(name: 'expiration')
  String? expiration;
  @JsonKey(name: 'profile_name')
  String? profileName;
  // @JsonKey(name: 'profile_id')
  // int? profileId;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'balance')
  String? balance;
  @JsonKey(name: 'user_balance')
  String? userBalance;
  // @JsonKey(name: 'reward_points_balance')
  // String? rewardPointsBalance;
  @JsonKey(name: 'reward_points')
  int? rewardPoints;
  // @JsonKey(name: 'required_points')
  // int? requiredPoints;

  ExtendUserResponse(
    // this.remainingRxtx,
    // this.remainingRx,
    // this.remainingTx,
    // this.remainingUptime,
    this.expiration,
    this.profileName,
    // this.profileId,
    this.username,
    this.balance,
    this.userBalance,
    // this.rewardPointsBalance,
    this.rewardPoints,
    // this.requiredPoints,
  );
  factory ExtendUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtendUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExtendUserResponseToJson(this);
}
