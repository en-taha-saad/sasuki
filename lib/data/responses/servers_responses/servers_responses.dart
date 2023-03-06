// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'servers_responses.g.dart';

@JsonSerializable()
class ServersListResponse {
  @JsonKey(name: 'servers')
  List<ServerResponse>? servers;

  ServersListResponse(this.servers);

  // toJson
  Map<String, dynamic> toJson() => _$ServersListResponseToJson(this);

//fromJson
  factory ServersListResponse.fromJson(Map<String, dynamic> json) =>
      _$ServersListResponseFromJson(json);
}

@JsonSerializable()
class ServerResponse {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'hostname')
  String? hostName;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'password')
  String? password;

  ServerResponse(
    this.name,
    this.hostName,
    this.username,
    this.password,
  );

  // toJson
  Map<String, dynamic> toJson() => _$ServerResponseToJson(this);

//fromJson
  factory ServerResponse.fromJson(Map<String, dynamic> json) =>
      _$ServerResponseFromJson(json);
}
