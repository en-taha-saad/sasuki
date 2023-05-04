import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/payment_methods_responses/deposit_action_responses.dart';
import 'package:sasuki/domain/models/payment_methods/deposit_action.dart';

extension DepositActionResponseMapper on DepositActionResponse? {
  DepositAction toDomain() {
    return DepositAction(
      this?.status?.orZero(),
      this?.data?.orEmpty(),
    );
  }
}
