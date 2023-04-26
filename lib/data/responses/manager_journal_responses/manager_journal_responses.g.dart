// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_journal_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerJournalResponses _$ManagerJournalResponsesFromJson(
        Map<String, dynamic> json) =>
    ManagerJournalResponses(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ManagerJournalDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$ManagerJournalResponsesToJson(
        ManagerJournalResponses instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

ManagerJournalDataResponse _$ManagerJournalDataResponseFromJson(
        Map<String, dynamic> json) =>
    ManagerJournalDataResponse(
      json['id'] as int?,
      json['amount'] as String?,
      json['created_at'] as String?,
      json['description'] as String?,
      json['comment'] as String?,
      json['balance'] as String?,
      json['cr'] as String?,
      json['dr'] as String?,
      json['operation'] as String?,
    );

Map<String, dynamic> _$ManagerJournalDataResponseToJson(
        ManagerJournalDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'created_at': instance.createdAt,
      'cr': instance.credit,
      'dr': instance.debt,
      'operation': instance.operation,
      'description': instance.description,
      'comment': instance.comment,
      'balance': instance.balance,
    };
