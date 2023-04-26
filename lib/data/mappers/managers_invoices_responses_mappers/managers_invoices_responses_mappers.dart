import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/managers_invoices_responses/managers_invoices_responses.dart';
import 'package:sasuki/domain/models/managers_invoices/managers_invoices.dart';

extension ManagersInvoicesResponsesMapper on ManagersInvoicesResponses? {
  ManagersInvoices toDomain() {
    return ManagersInvoices(
      this?.data?.map((e) => e.toDomain()).toList(),
      this?.total.orZero(),
    );
  }
}

extension ManagersInvoiceDataResponseMapper on ManagersInvoiceDataResponse? {
  ManagersInvoiceData toDomain() {
    return ManagersInvoiceData(
      this?.id.orZero(),
      this?.invoiceNumber.orEmpty(),
      this?.type.orEmpty(),
      this?.amount.orEmpty(),
      this?.createdAt.orEmpty(),
      this?.issuerDetails.toDomain(),
      this?.description.orEmpty(),
      this?.paid.orEmpty(),
      this?.paymentMethod.orEmpty(),
      this?.comments.orEmpty(),
      this?.ownerDetails.toDomain(),
    );
  }
}

extension IssuerDetailsResponseMapper on IssuerDetailsResponse? {
  IssuerDetails toDomain() {
    return IssuerDetails(
      this?.id.orZero(),
      this?.username.orEmpty(),
    );
  }
}

extension OwnerDetailsResponseMapper on OwnerDetailsResponse? {
  OwnerDetails toDomain() {
    return OwnerDetails(
      this?.id.orZero(),
      this?.username.orEmpty(),
    );
  }
}
