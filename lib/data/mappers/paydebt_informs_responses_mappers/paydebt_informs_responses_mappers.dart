import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/data/responses/paydebt_informs_responses/paydebt_informs_responses.dart';
import 'package:sasuki/domain/models/paydebt_informs/paydebt_informs.dart';

extension PaydebtInformsResponsesMapper on PaydebtInformsResponses? {
  PaydebtInforms toDomain() {
    return PaydebtInforms(
      this?.status.orZero(),
      this?.data.toDomain(),
    );
  }
}

extension PaydebtDataResponsesMapper on PaydebtDataResponses? {
  PaydebtData toDomain() {
    return PaydebtData(
      this?.total.orZero(),
      this?.debtForMe.orZero(),
      // this?.username.orEmpty(),
      // this?.balance.orZero(),
    );
  }
}
