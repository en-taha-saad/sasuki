// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'activate_method_responses.g.dart';

@JsonSerializable()
class ActivateMethodResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;

  ActivateMethodResponse(
    this.status,
    this.message,
  );
  Map<String, dynamic> toJson() => _$ActivateMethodResponseToJson(this);
  factory ActivateMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivateMethodResponseFromJson(json);
}
