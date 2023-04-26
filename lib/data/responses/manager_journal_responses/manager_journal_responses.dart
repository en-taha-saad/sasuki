// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'manager_journal_responses.g.dart';

@JsonSerializable()
class ManagerJournalResponses {
  @JsonKey(name: 'data')
  List<ManagerJournalDataResponse>? data;
  @JsonKey(name: 'total')
  int? total;

  ManagerJournalResponses(this.data, this.total);
  Map<String, dynamic> toJson() => _$ManagerJournalResponsesToJson(this);
  factory ManagerJournalResponses.fromJson(Map<String, dynamic> json) =>
      _$ManagerJournalResponsesFromJson(json);
}

@JsonSerializable()
class ManagerJournalDataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'amount')
  String? amount;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'cr')
  String? credit;
  @JsonKey(name: 'dr')
  String? debt;
  @JsonKey(name: 'operation')
  String? operation;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'comment')
  String? comment;
  @JsonKey(name: 'balance')
  String? balance;

  ManagerJournalDataResponse(
    this.id,
    this.amount,
    this.createdAt,
    this.description,
    this.comment,
    this.balance,
    this.credit,
    this.debt,
    this.operation,
  );
  Map<String, dynamic> toJson() => _$ManagerJournalDataResponseToJson(this);
  factory ManagerJournalDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ManagerJournalDataResponseFromJson(json);
}
