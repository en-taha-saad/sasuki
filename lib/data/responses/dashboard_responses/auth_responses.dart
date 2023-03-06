// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'auth_responses.g.dart';

@JsonSerializable()
class AuthResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'client')
  ClientResponse? client;
  @JsonKey(name: 'permissions')
  List<String>? permissions;
  // @JsonKey(name: 'features')
  // List<String>? features;
  // @JsonKey(name: 'license_status')
  // String? licenseStatus;
  // @JsonKey(name: 'license_expiration')
  // String? licenseExpiration;
  // @JsonKey(name: 'mu')
  // String? mu;

  AuthResponses(
    this.status,
    this.client,
    this.permissions,
    // this.features,
    // this.licenseStatus,
    // this.licenseExpiration,
    // this.mu,
  );
  factory AuthResponses.fromJson(Map<String, dynamic> json) =>
      _$AuthResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponsesToJson(this);
}

@JsonSerializable()
class ClientResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  // @JsonKey(name: 'enabled')
  // int? enabled;
  // @JsonKey(name: 'city')
  // String? city;
  // @JsonKey(name: 'country')
  // String? country;
  @JsonKey(name: 'firstname')
  String? firstname;
  @JsonKey(name: 'lastname')
  String? lastname;
  // @JsonKey(name: 'email')
  // String? email;
  // @JsonKey(name: 'phone')
  // String? phone;
  // @JsonKey(name: 'company')
  // String? company;
  // @JsonKey(name: 'address')
  // String? address;
  @JsonKey(name: 'balance')
  double? balance;
  // @JsonKey(name: 'loan_balance')
  // int? loanBalance;
  // @JsonKey(name: 'debt_limit')
  // String? debtLimit;
  // @JsonKey(name: 'subscriber_suffix')
  // String? subscriberSuffix;
  // @JsonKey(name: 'subscriber_prefix')
  // String? subscriberPrefix;
  // @JsonKey(name: 'notes')
  // String? notes;
  // @JsonKey(name: 'manager_id')
  // int? managerId;
  // @JsonKey(name: 'mobile_auth_secret')
  // String? mobileAuthSecret;
  // @JsonKey(name: 'max_users')
  // int? maxUsers;
  // @JsonKey(name: 'mikrotik_addresslist')
  // String? mikrotikAddresslist;
  // @JsonKey(name: 'created_at')
  // String? createdAt;
  // @JsonKey(name: 'updated_at')
  // String? updatedAt;
  // @JsonKey(name: 'deleted_at')
  // String? deletedAt;
  // @JsonKey(name: 'acl_group_id')
  // int? aclGroupId;
  // @JsonKey(name: 'site_id')
  // String? siteId;
  // @JsonKey(name: 'avatar')
  // String? avatar;
  // @JsonKey(name: 'parent_id')
  // int? parentId;
  // @JsonKey(name: 'created_by')
  // int? createdBy;
  // @JsonKey(name: 'reward_points')
  // int? rewardPoints;
  // @JsonKey(name: 'discount_rate')
  // String? discountRate;
  // @JsonKey(name: 'admin_notes')
  // String? adminNotes;
  // @JsonKey(name: 'limit_delete')
  // int? limitDelete;
  // @JsonKey(name: 'limit_delete_count')
  // int? limitDeleteCount;
  // @JsonKey(name: 'limit_rename')
  // int? limitRename;
  // @JsonKey(name: 'limit_rename_count')
  // int? limitRenameCount;
  // @JsonKey(name: 'limit_profile_change')
  // int? limitProfileChange;
  // @JsonKey(name: 'limit_profile_change_count')
  // int? limitProfileChangeCount;
  // @JsonKey(name: 'limit_mac_change')
  // int? limitMacChange;
  // @JsonKey(name: 'limit_mac_change_count')
  // int? limitMacChangeCount;
  // @JsonKey(name: 'requires_2fa')
  // int? requires2fa;
  // @JsonKey(name: 'group_id')
  // int? groupId;
  // @JsonKey(name: 'force_change_password')
  // int? forceChangePassword;
  // @JsonKey(name: 'avatar_data')
  // String? avatarData;
  ClientResponse(
    this.id,
    this.username,
    // this.enabled,
    // this.city,
    // this.country,
    this.firstname,
    this.lastname,
    // this.email,
    // this.phone,
    // this.company,
    // this.address,
    this.balance,
    // this.loanBalance,
    // this.debtLimit,
    // this.subscriberSuffix,
    // this.subscriberPrefix,
    // this.notes,
    // this.managerId,
    // this.mobileAuthSecret,
    // this.maxUsers,
    // this.mikrotikAddresslist,
    // this.createdAt,
    // this.updatedAt,
    // this.deletedAt,
    // this.aclGroupId,
    // this.siteId,
    // this.avatar,
    // this.parentId,
    // this.createdBy,
    // this.rewardPoints,
    // this.discountRate,
    // this.adminNotes,
    // this.limitDelete,
    // this.limitDeleteCount,
    // this.limitRename,
    // this.limitRenameCount,
    // this.limitProfileChange,
    // this.limitProfileChangeCount,
    // this.limitMacChange,
    // this.limitMacChangeCount,
    // this.requires2fa,
    // this.groupId,
    // this.forceChangePassword,
    // this.avatarData,
  );

  factory ClientResponse.fromJson(Map<String, dynamic> json) =>
      _$ClientResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ClientResponseToJson(this);
}
