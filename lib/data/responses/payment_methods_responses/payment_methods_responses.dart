// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'payment_methods_responses.g.dart';

@JsonSerializable()
class PaymentMethodsResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  List<SinglePaymentMethodResponses>? data;

  PaymentMethodsResponses(this.status, this.data);
  // toJson
  Map<String, dynamic> toJson() => _$PaymentMethodsResponsesToJson(this);

//fromJson
  factory PaymentMethodsResponses.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsResponsesFromJson(json);
}

@JsonSerializable()
class SinglePaymentMethodResponses {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'internalName')
  String? internalName;

  SinglePaymentMethodResponses(
      this.id, this.name, this.country, this.internalName);
  // toJson
  Map<String, dynamic> toJson() => _$SinglePaymentMethodResponsesToJson(this);

//fromJson
  factory SinglePaymentMethodResponses.fromJson(Map<String, dynamic> json) =>
      _$SinglePaymentMethodResponsesFromJson(json);
}
