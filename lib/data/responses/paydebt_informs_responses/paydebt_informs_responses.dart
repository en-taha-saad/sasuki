// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'paydebt_informs_responses.g.dart';

@JsonSerializable()
class PaydebtInformsResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  PaydebtDataResponses? data;

  PaydebtInformsResponses(this.status, this.data);
  Map<String, dynamic> toJson() => _$PaydebtInformsResponsesToJson(this);
  factory PaydebtInformsResponses.fromJson(Map<String, dynamic> json) =>
      _$PaydebtInformsResponsesFromJson(json);
}

@JsonSerializable()
class PaydebtDataResponses {
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'debt_for_me')
  int? debtForMe;
  // @JsonKey(name: 'username')
  // String? username;
  // @JsonKey(name: 'balance')
  // int? balance;

  PaydebtDataResponses(
    this.total,
    this.debtForMe,
  //   this.username,
  //   this.balance,
  );

  Map<String, dynamic> toJson() => _$PaydebtDataResponsesToJson(this);
  factory PaydebtDataResponses.fromJson(Map<String, dynamic> json) {
    
    return _$PaydebtDataResponsesFromJson(json);
  }
}
