import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/payment_methods_responses/payment_methods_responses.dart';
import 'package:sasuki/domain/models/payment_methods/payment_methods.dart';

extension PaymentMethodsResponsesMapper on PaymentMethodsResponses? {
  PaymentMethods toDomain() {
    return PaymentMethods(
      this?.status?.orZero(),
      this?.data?.map((e) => e.toDomain()).cast<SinglePaymentMethod>().toList(),
    );
  }
}

extension SinglePaymentMethodResponsesMapper on SinglePaymentMethodResponses? {
  SinglePaymentMethod toDomain() {
    return SinglePaymentMethod(
      this?.id?.orZero(),
      this?.name?.orEmpty(),
      this?.country?.orEmpty(),
      this?.internalName?.orEmpty(),
    );
  }
}
