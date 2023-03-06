// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'allowed_extersion_methods_responses.g.dart';

@JsonSerializable()
class AllowedExtersionMethodsResponses {
  int? i0;
  int? status;
  List<ExtensionResponse>? data;

  AllowedExtersionMethodsResponses(this.i0, this.status, this.data);
  factory AllowedExtersionMethodsResponses.fromJson(
          Map<String, dynamic> json) =>
      _$AllowedExtersionMethodsResponsesFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AllowedExtersionMethodsResponsesToJson(this);
}

@JsonSerializable()
class ExtensionResponse {
  int? id;
  String? name;
  // String? price;

  ExtensionResponse(this.id, this.name);
  // ExtensionResponse(this.id, this.name, this.price);
  factory ExtensionResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtensionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExtensionResponseToJson(this);
}
