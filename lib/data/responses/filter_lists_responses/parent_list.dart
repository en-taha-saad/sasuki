// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'parent_list.g.dart';

@JsonSerializable()
class SingleParentDataResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'parent_id')
  int? parentId;
  @JsonKey(name: 'username')
  String? username;

  SingleParentDataResponses(this.id, this.parentId, this.username);
  factory SingleParentDataResponses.fromJson(Map<String, dynamic> json) =>
      _$SingleParentDataResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$SingleParentDataResponsesToJson(this);
}
