// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'manager_list_details_responses.g.dart';

@JsonSerializable()
class ManagerListDetailsResponses {
  @JsonKey(name: 'data')
  List<SingleManagerDetailsResponses>? data;
  @JsonKey(name: 'total')
  int? total;

  ManagerListDetailsResponses(this.data, this.total);
  factory ManagerListDetailsResponses.fromJson(Map<String, dynamic> json) =>
      _$ManagerListDetailsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ManagerListDetailsResponsesToJson(this);
}

@JsonSerializable()
class SingleManagerDetailsResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'firstname')
  String? firstname;
  @JsonKey(name: 'lastname')
  String? lastname;
  @JsonKey(name: 'balance')
  double? balance;
  @JsonKey(name: 'enabled')
  int? enabled;
  @JsonKey(name: 'users_count')
  int? userCount;
  @JsonKey(name: 'acl_group_details')
  AclGroupDetailsResponses? aclGroupDetails;


  SingleManagerDetailsResponses(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.balance,
    this.enabled,
    this.userCount,
    this.aclGroupDetails,
  );
  factory SingleManagerDetailsResponses.fromJson(Map<String, dynamic> json) =>
      _$SingleManagerDetailsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$SingleManagerDetailsResponsesToJson(this);
}

@JsonSerializable()
class AclGroupDetailsResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'dashboard_id')
  int? dashboardId;

  AclGroupDetailsResponses(this.id, this.name, this.dashboardId);
  factory AclGroupDetailsResponses.fromJson(Map<String, dynamic> json) =>
      _$AclGroupDetailsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$AclGroupDetailsResponsesToJson(this);
}
