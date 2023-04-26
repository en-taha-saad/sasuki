// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managers_invoices_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagersInvoicesResponses _$ManagersInvoicesResponsesFromJson(
        Map<String, dynamic> json) =>
    ManagersInvoicesResponses(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ManagersInvoiceDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$ManagersInvoicesResponsesToJson(
        ManagersInvoicesResponses instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

ManagersInvoiceDataResponse _$ManagersInvoiceDataResponseFromJson(
        Map<String, dynamic> json) =>
    ManagersInvoiceDataResponse(
      json['id'] as int?,
      json['invoice_number'] as String?,
      json['type'] as String?,
      json['amount'] as String?,
      json['created_at'] as String?,
      json['issuer_details'] == null
          ? null
          : IssuerDetailsResponse.fromJson(
              json['issuer_details'] as Map<String, dynamic>),
      json['description'] as String?,
      json['paid'] as String?,
      json['payment_method'] as String?,
      json['comments'] as String?,
      json['owner_details'] == null
          ? null
          : OwnerDetailsResponse.fromJson(
              json['owner_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManagersInvoiceDataResponseToJson(
        ManagersInvoiceDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_number': instance.invoiceNumber,
      'type': instance.type,
      'amount': instance.amount,
      'created_at': instance.createdAt,
      'issuer_details': instance.issuerDetails,
      'description': instance.description,
      'paid': instance.paid,
      'payment_method': instance.paymentMethod,
      'comments': instance.comments,
      'owner_details': instance.ownerDetails,
    };

IssuerDetailsResponse _$IssuerDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    IssuerDetailsResponse(
      json['id'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$IssuerDetailsResponseToJson(
        IssuerDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };

OwnerDetailsResponse _$OwnerDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    OwnerDetailsResponse(
      json['id'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$OwnerDetailsResponseToJson(
        OwnerDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };
