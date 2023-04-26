// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'managers_invoices_responses.g.dart';

@JsonSerializable()
class ManagersInvoicesResponses {
  @JsonKey(name: 'data')
  List<ManagersInvoiceDataResponse>? data;
  @JsonKey(name: 'total')
  int? total;

  ManagersInvoicesResponses(this.data, this.total);
  Map<String, dynamic> toJson() => _$ManagersInvoicesResponsesToJson(this);
  factory ManagersInvoicesResponses.fromJson(Map<String, dynamic> json) =>
      _$ManagersInvoicesResponsesFromJson(json);
}

@JsonSerializable()
class ManagersInvoiceDataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'invoice_number')
  String? invoiceNumber;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'amount')
  String? amount;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'issuer_details')
  IssuerDetailsResponse? issuerDetails;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'paid')
  String? paid;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;
  @JsonKey(name: 'comments')
  String? comments;
  @JsonKey(name: 'owner_details')
  OwnerDetailsResponse? ownerDetails;

  ManagersInvoiceDataResponse(
    this.id,
    this.invoiceNumber,
    this.type,
    this.amount,
    this.createdAt,
    this.issuerDetails,
    this.description,
    this.paid,
    this.paymentMethod,
    this.comments,
    this.ownerDetails,
  );
  Map<String, dynamic> toJson() => _$ManagersInvoiceDataResponseToJson(this);
  factory ManagersInvoiceDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ManagersInvoiceDataResponseFromJson(json);
}

@JsonSerializable()
class IssuerDetailsResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;

  IssuerDetailsResponse(this.id, this.username);
  Map<String, dynamic> toJson() => _$IssuerDetailsResponseToJson(this);
  factory IssuerDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$IssuerDetailsResponseFromJson(json);
}

@JsonSerializable()
class OwnerDetailsResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;

  OwnerDetailsResponse(this.id, this.username);
  Map<String, dynamic> toJson() => _$OwnerDetailsResponseToJson(this);
  factory OwnerDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$OwnerDetailsResponseFromJson(json);
}
