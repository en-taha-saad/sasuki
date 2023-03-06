// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'profile_list.g.dart';

@JsonSerializable()
class ProfileListResponses {
  @JsonKey(name: 'i0')
  int? i0;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  List<ProfileDataResponses> data;

  ProfileListResponses(this.i0, this.status, this.data);
  factory ProfileListResponses.fromJson(Map<String, dynamic> json) =>
      _$ProfileListResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileListResponsesToJson(this);
}

@JsonSerializable()
class ProfileDataResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  ProfileDataResponses(this.id, this.name);
  factory ProfileDataResponses.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDataResponsesToJson(this);
}
