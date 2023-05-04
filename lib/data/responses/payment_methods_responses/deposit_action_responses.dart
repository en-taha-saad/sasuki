// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'deposit_action_responses.g.dart';

@JsonSerializable()
class DepositActionResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  String? data;

  DepositActionResponse(this.status, this.data);

  // toJson
  Map<String, dynamic> toJson() => _$DepositActionResponseToJson(this);

//fromJson
  factory DepositActionResponse.fromJson(Map<String, dynamic> json) =>
      _$DepositActionResponseFromJson(json);

}
