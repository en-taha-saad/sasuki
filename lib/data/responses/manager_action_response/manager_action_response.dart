// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'manager_action_response.g.dart';

@JsonSerializable()
class ManagerActionResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'error')
  String? error;

  ManagerActionResponse(this.status, this.error);
  Map<String, dynamic> toJson() => _$ManagerActionResponseToJson(this);
  factory ManagerActionResponse.fromJson(Map<String, dynamic> json) =>
      _$ManagerActionResponseFromJson(json);
}
