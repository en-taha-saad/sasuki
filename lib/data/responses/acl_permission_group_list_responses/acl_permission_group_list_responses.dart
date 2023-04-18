// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'acl_permission_group_list_responses.g.dart';

@JsonSerializable()
class AclPermissionGroupListResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  List<SingleAclPermissionGroupResponses>? data;

  AclPermissionGroupListResponses(this.status, this.data);
  factory AclPermissionGroupListResponses.fromJson(Map<String, dynamic> json) =>
      _$AclPermissionGroupListResponsesFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AclPermissionGroupListResponsesToJson(this);
}

@JsonSerializable()
class SingleAclPermissionGroupResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'dashboard_id')
  int? dashboardId;

  SingleAclPermissionGroupResponses(this.id, this.name, this.dashboardId);
  factory SingleAclPermissionGroupResponses.fromJson(
          Map<String, dynamic> json) =>
      _$SingleAclPermissionGroupResponsesFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SingleAclPermissionGroupResponsesToJson(this);
}
