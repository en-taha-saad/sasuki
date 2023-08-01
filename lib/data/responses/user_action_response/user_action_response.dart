// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'user_action_response.g.dart';

@JsonSerializable()
class UserActionResponse {
  // @JsonKey(name: 'error')
  String? message;
  @JsonKey(name: 'status')
  int? status;

  UserActionResponse(this.status, this.message);
  Map<String, dynamic> toJson() => _$UserActionResponseToJson(this);
  factory UserActionResponse.fromJson(Map<String, dynamic> json) {
    return UserActionResponse(
      json['status'] as int?,
      json['message'] as String? ?? json['error'] as String?,
    );
  }
}

@JsonSerializable()
class EditUserResponse {
  @JsonKey(name: 'status')
  int? status;

  EditUserResponse(this.status);
  Map<String, dynamic> toJson() => _$EditUserResponseToJson(this);
  factory EditUserResponse.fromJson(Map<String, dynamic> json) =>
      _$EditUserResponseFromJson(json);
}
