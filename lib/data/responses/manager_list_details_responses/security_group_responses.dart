// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'security_group_responses.g.dart';

@JsonSerializable()
class SecurityGroupResponses {
  @JsonKey(name: 'data')
  List<SingleACLResponses>? data;
  @JsonKey(name: 'status')
  int? status;

  SecurityGroupResponses(this.data, this.status);
  factory SecurityGroupResponses.fromJson(Map<String, dynamic> json) =>
      _$SecurityGroupResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityGroupResponsesToJson(this);
}

@JsonSerializable()
class SingleACLResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'dashboard_id')
  int? dashboardId;

  SingleACLResponses(this.id, this.name, this.dashboardId);
  factory SingleACLResponses.fromJson(Map<String, dynamic> json) =>
      _$SingleACLResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$SingleACLResponsesToJson(this);
}
