// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'activity_log_list_responses.g.dart';

@JsonSerializable()
class ActivityLogListResponses {
  @JsonKey(name: 'data')
  List<ActivityLogRes?>? data;
  @JsonKey(name: 'total')
  int? total;

  ActivityLogListResponses(this.data, this.total);

  factory ActivityLogListResponses.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogListResponsesFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLogListResponsesToJson(this);
}

@JsonSerializable()
class ActivityLogRes {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'created_by')
  int? createdBy;
  @JsonKey(name: 'event')
  String? event;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'ip')
  String? ip;
  @JsonKey(name: 'manager_details')
  ManagerDetails? managerDetails;

  ActivityLogRes(
    this.id,
    this.createdAt,
    this.createdBy,
    this.event,
    this.description,
    this.ip,
    this.managerDetails,
  );

  factory ActivityLogRes.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogResFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLogResToJson(this);
}

@JsonSerializable()
class ManagerDetails {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'firstname')
  String? firstName;
  @JsonKey(name: 'lastname')
  String? lastName;

  ManagerDetails(this.id, this.username, this.firstName, this.lastName);

  factory ManagerDetails.fromJson(Map<String, dynamic> json) =>
      _$ManagerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerDetailsToJson(this);
}
