// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'dashboard_data_responses.g.dart';

@JsonSerializable()
class DashboardResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  DashboardDataResponse? data;

  DashboardResponse(this.status, this.data);
  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}

@JsonSerializable()
class DashboardDataResponse {
  @JsonKey(name: 'users_count')
  int? usersCount;
  @JsonKey(name: 'users_online_count')
  int? usersOnlineCount;
  @JsonKey(name: 'active_users_count')
  int? activeUsersCount;
  @JsonKey(name: 'expired_users_count')
  int? expiredUsersCount;
  @JsonKey(name: 'expiring_soon_count')
  int? expiringSoonCount;
  @JsonKey(name: 'balance')
  double? balance;
  @JsonKey(name: 'reward_points_balance')
  int? rewardPointsBalance;
  @JsonKey(name: 'registred_today')
  int? registredToday;
  @JsonKey(name: 'activations_today')
  int? activationsToday;
  @JsonKey(name: 'sales_today')
  int? salesToday;
  @JsonKey(name: 'profits_today')
  int? profitsToday;

  DashboardDataResponse(
    this.usersCount,
    this.usersOnlineCount,
    this.activeUsersCount,
    this.expiredUsersCount,
    this.expiringSoonCount,
    this.balance,
    this.rewardPointsBalance,
    this.registredToday,
    this.activationsToday,
    this.salesToday,
    this.profitsToday,
  );
  factory DashboardDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardDataResponseToJson(this);
}
