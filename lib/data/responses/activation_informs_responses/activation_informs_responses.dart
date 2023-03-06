// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'activation_informs_responses.g.dart';

@JsonSerializable()
class ActivationInformsResponse {
  @JsonKey(name: 'data')
  ActivationInformsDataResponse? data;
  @JsonKey(name: 'status')
  int? status;
  ActivationInformsResponse(this.data, this.status);
  Map<String, dynamic> toJson() => _$ActivationInformsResponseToJson(this);
  factory ActivationInformsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivationInformsResponseFromJson(json);
}

@JsonSerializable()
class ActivationInformsDataResponse {
  // @JsonKey(name: 'username')
  // String? username;
  // @JsonKey(name: 'profile_name')
  // String? profileName;
  // @JsonKey(name: 'profile_id')
  // int? profileId;
  // @JsonKey(name: 'parent_id')
  // int? parentId;
  @JsonKey(name: 'manager_balance')
  String? managerBalance;
  @JsonKey(name: 'user_balance')
  String? userBalance;
  // @JsonKey(name: 'user_expiration')
  // String? userExpiration;
  @JsonKey(name: 'unit_price')
  String? unitPrice;
  @JsonKey(name: 'user_price')
  double? userPrice;
  // @JsonKey(name: 'profile_duration')
  // String? profileDuration;
  // @JsonKey(name: 'profile_traffic')
  // String? profileTraffic;
  // @JsonKey(name: 'profile_dl_traffic')
  // String? profileDlTraffic;
  // @JsonKey(name: 'profile_ul_traffic')
  // String? profileUlTraffic;
  // @JsonKey(name: 'profile_description')
  // String? profileDescription;
  // @JsonKey(name: 'vat')
  // String? vat;
  // @JsonKey(name: 'units')
  // int? units;
  // @JsonKey(name: 'required_amount')
  // String? requiredAmount;
  // @JsonKey(name: 'n_required_amount')
  // int? nRequiredAmount;
  // @JsonKey(name: 'reward_points')
  // int? rewardPoints;
  // @JsonKey(name: 'required_points')
  // int? requiredPoints;
  // @JsonKey(name: 'reward_points_balance')
  // int? rewardPointsBalance;

  ActivationInformsDataResponse(
    // this.username,
    // this.profileName,
    // this.profileId,
    // this.parentId,
    this.managerBalance,
    this.userBalance,
    // this.userExpiration,
    this.unitPrice,
    this.userPrice,
    // this.profileDuration,
    // this.profileTraffic,
    // this.profileDlTraffic,
    // this.profileUlTraffic,
    // this.profileDescription,
    // this.vat,
    // this.units,
    // this.requiredAmount,
    // this.nRequiredAmount,
    // this.rewardPoints,
    // this.requiredPoints,
    // this.rewardPointsBalance,
  );
  Map<String, dynamic> toJson() => _$ActivationInformsDataResponseToJson(this);
  factory ActivationInformsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivationInformsDataResponseFromJson(json);
}
