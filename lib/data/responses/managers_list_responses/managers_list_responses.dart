// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'managers_list_responses.g.dart';

@JsonSerializable()
class ManagersListResponses {
  @JsonKey(name: '0')
  int? i0;
  @JsonKey(name: 'data')
  List<SingleManagerDataResponses>? data;

  ManagersListResponses(this.i0, this.data);
  factory ManagersListResponses.fromJson(Map<String, dynamic> json) =>
      _$ManagersListResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ManagersListResponsesToJson(this);
}

@JsonSerializable()
class SingleManagerDataResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;

  SingleManagerDataResponses(this.id, this.username);
  factory SingleManagerDataResponses.fromJson(Map<String, dynamic> json) =>
      _$SingleManagerDataResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$SingleManagerDataResponsesToJson(this);
}
