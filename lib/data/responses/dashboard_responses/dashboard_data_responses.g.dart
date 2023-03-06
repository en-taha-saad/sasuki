// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      json['status'] as int?,
      json['data'] == null
          ? null
          : DashboardDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

DashboardDataResponse _$DashboardDataResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardDataResponse(
      json['users_count'] as int?,
      json['users_online_count'] as int?,
      json['active_users_count'] as int?,
      json['expired_users_count'] as int?,
      json['expiring_soon_count'] as int?,
      (json['balance'] as num?)?.toDouble(),
      json['reward_points_balance'] as int?,
      json['registred_today'] as int?,
      json['activations_today'] as int?,
      json['sales_today'] as int?,
      json['profits_today'] as int?,
    );

Map<String, dynamic> _$DashboardDataResponseToJson(
        DashboardDataResponse instance) =>
    <String, dynamic>{
      'users_count': instance.usersCount,
      'users_online_count': instance.usersOnlineCount,
      'active_users_count': instance.activeUsersCount,
      'expired_users_count': instance.expiredUsersCount,
      'expiring_soon_count': instance.expiringSoonCount,
      'balance': instance.balance,
      'reward_points_balance': instance.rewardPointsBalance,
      'registred_today': instance.registredToday,
      'activations_today': instance.activationsToday,
      'sales_today': instance.salesToday,
      'profits_today': instance.profitsToday,
    };
