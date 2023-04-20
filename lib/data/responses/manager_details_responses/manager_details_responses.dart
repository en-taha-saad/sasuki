// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'manager_details_responses.g.dart';

@JsonSerializable()
class ManagerDetailsResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  ManagerDetailsDataResponses? data;

  ManagerDetailsResponses(this.status, this.data);

  Map<String, dynamic> toJson() => _$ManagerDetailsResponsesToJson(this);
  factory ManagerDetailsResponses.fromJson(Map<String, dynamic> json) =>
      _$ManagerDetailsResponsesFromJson(json);
}

@JsonSerializable()
class ManagerDetailsDataResponses {
  // make serialixable with json_serializable

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'enabled')
  int? enabled;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'firstname')
  String? firstname;
  @JsonKey(name: 'lastname')
  String? lastname;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'company')
  String? company;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'balance')
  int? balance;
  @JsonKey(name: 'notes')
  String? notes;
  @JsonKey(name: 'managerId')
  int? managerId;
  @JsonKey(name: 'maxUsers')
  int? maxUsers;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'deletedAt')
  String? deletedAt;
  @JsonKey(name: 'aclGroupId')
  int? aclGroupId;
  @JsonKey(name: 'parentId')
  int? parentId;
  @JsonKey(name: 'createdBy')
  int? createdBy;

  ManagerDetailsDataResponses(
    this.id,
    this.username,
    this.enabled,
    this.city,
    this.country,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.company,
    this.address,
    this.balance,
    this.notes,
    this.managerId,
    this.maxUsers,
    this.createdAt,
    this.deletedAt,
    this.aclGroupId,
    this.parentId,
    this.createdBy,
  );

  Map<String, dynamic> toJson() => _$ManagerDetailsDataResponsesToJson(this);
  factory ManagerDetailsDataResponses.fromJson(Map<String, dynamic> json) =>
      _$ManagerDetailsDataResponsesFromJson(json);
}
