// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'users_list_responses.g.dart';

@JsonSerializable()
class UsersListResponse {
  // @JsonKey(name: 'current_page')
  // int? currentPage;
  @JsonKey(name: 'data')
  List<UsersListDataResponse>? data;
  // @JsonKey(name: 'first_page_url')
  // String? firstPageUrl;
  // @JsonKey(name: 'from')
  // int? from;
  // @JsonKey(name: 'last_page')
  // int? lastPage;
  // @JsonKey(name: 'last_page_url')
  // String? lastPageUrl;
  // @JsonKey(name: 'next_page_url')
  // String? nextPageUrl;
  // @JsonKey(name: 'path')
  // String? path;
  // @JsonKey(name: 'per_page')
  // int? perPage;
  // @JsonKey(name: 'to')
  // int? to;
  @JsonKey(name: 'total')
  int? total;

  UsersListResponse(
    // this.currentPage,
    this.data,
    // this.firstPageUrl,
    // this.from,
    // this.lastPage,
    // this.lastPageUrl,
    // this.nextPageUrl,
    // this.path,
    // this.perPage,
    // this.to,
    this.total,
  );

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UsersListResponseToJson(this);
}

@JsonSerializable()
class UsersListDataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'firstname')
  String? firstname;
  @JsonKey(name: 'lastname')
  String? lastname;
  // @JsonKey(name: 'city')
  // String? city;
  // @JsonKey(name: 'phone')
  // String? phone;
  // @JsonKey(name: 'profile_id')
  // int? profileId;
  // @JsonKey(name: 'balance')
  // String? balance;
  @JsonKey(name: 'expiration')
  String? expiration;
  // @JsonKey(name: 'parent_id')
  // int? parentId;
  @JsonKey(name: 'enabled')
  int? enabled;
  @JsonKey(name: 'notes')
  String? notes;
  // @JsonKey(name: 'simultaneous_sessions')
  // int? simultaneousSessions;
  // @JsonKey(name: 'address')
  // String? address;
  // @JsonKey(name: 'contract_id')
  // String? contractId;
  // @JsonKey(name: 'created_at')
  // String? createdAt;
  // @JsonKey(name: 'group_id')
  // int? groupId;
  // @JsonKey(name: 'n_row')
  // int? nRow;
  @JsonKey(name: 'status')
  StatusResponses? status;
  @JsonKey(name: 'online_status')
  int? onlineStatus;
  // @JsonKey(name: 'parent_username')
  // String? parentUsername;
  @JsonKey(name: 'profile_details')
  ProfileDetailsResponses? profileDetails;
  // @JsonKey(name: 'group_details')
  // GroupDetailsResponses? groupDetails;

  UsersListDataResponse(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    // this.city,
    // this.phone,
    // this.profileId,
    // this.balance,
    this.expiration,
    // this.parentId,
    this.enabled,
    this.notes,
    // this.simultaneousSessions,
    // this.address,
    // this.contractId,
    // this.createdAt,
    // this.groupId,
    // this.nRow,
    this.status,
    this.onlineStatus,
    // this.parentUsername,
    this.profileDetails,
    // this.groupDetails,
  );

  factory UsersListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersListDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UsersListDataResponseToJson(this);
}

@JsonSerializable()
class StatusResponses {
  @JsonKey(name: 'status')
  bool? status;
  // @JsonKey(name: 'traffic')
  // bool? traffic;
  // @JsonKey(name: 'expiration')
  // bool? expiration;
  // @JsonKey(name: 'uptime')
  // bool? uptime;

  StatusResponses({
    this.status,
    // this.traffic,
    // this.expiration,
    // this.uptime,
  });

  factory StatusResponses.fromJson(Map<String, dynamic> json) =>
      _$StatusResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$StatusResponsesToJson(this);
}

@JsonSerializable()
class ProfileDetailsResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  int? type;

  ProfileDetailsResponses(
    this.id,
    this.name,
    this.type,
  );

  factory ProfileDetailsResponses.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDetailsResponsesToJson(this);
}

@JsonSerializable()
class GroupDetailsResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'group_name')
  String? groupName;

  GroupDetailsResponses(
    this.id,
    this.groupName,
  );

  factory GroupDetailsResponses.fromJson(Map<String, dynamic> json) =>
      _$GroupDetailsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$GroupDetailsResponsesToJson(this);
}
