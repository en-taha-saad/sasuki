// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'login_responses.g.dart';

@JsonSerializable()
class LoginResponse {
  int status;
  String? token;

  LoginResponse(this.status, this.token);
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
