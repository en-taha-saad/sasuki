// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'activations_reports_responses.g.dart';

@JsonSerializable()
class ActivationsReportsResponse {
  @JsonKey(name: 'data')
  List<ActivationResponse>? data;
  @JsonKey(name: 'total')
  int? total;

  ActivationsReportsResponse(this.data, this.total);

  Map<String, dynamic> toJson() => _$ActivationsReportsResponseToJson(this);
  factory ActivationsReportsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivationsReportsResponseFromJson(json);
}

@JsonSerializable()
class ActivationResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'price')
  String? price;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'user_details')
  UserDetailsResponse? userDetails;
  @JsonKey(name: 'manager_details')
  ManagerDetailsResponse? managerDetails;
  @JsonKey(name: 'profile_details')
  ProfileDetailsResponse? profileDetails;
  @JsonKey(name: 'old_expiration')
  String oldExpiration;
  @JsonKey(name: 'new_expiration')
  String newExpiration;
  @JsonKey(name: 'activation_method')
  String activationMethod;
  @JsonKey(name: 'user_activations_count')
  int userActivationsCount;

  ActivationResponse(
    this.id,
    this.price,
    this.createdAt,
    this.userDetails,
    this.managerDetails,
    this.profileDetails,
    this.oldExpiration,
    this.newExpiration,
    this.activationMethod,
    this.userActivationsCount,
  );
  Map<String, dynamic> toJson() => _$ActivationResponseToJson(this);
  factory ActivationResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivationResponseFromJson(json);
}

@JsonSerializable()
class UserDetailsResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'firstname')
  String? firstname;
  @JsonKey(name: 'lastname')
  String? lastname;

  UserDetailsResponse(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
  );
  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);
  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsResponseFromJson(json);
}

@JsonSerializable()
class ManagerDetailsResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;

  ManagerDetailsResponse(
    this.id,
    this.username,
  );
  Map<String, dynamic> toJson() => _$ManagerDetailsResponseToJson(this);
  factory ManagerDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ManagerDetailsResponseFromJson(json);
}

@JsonSerializable()
class ProfileDetailsResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  ProfileDetailsResponse(
    this.id,
    this.name,
  );
  Map<String, dynamic> toJson() => _$ProfileDetailsResponseToJson(this);
  factory ProfileDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsResponseFromJson(json);
}
