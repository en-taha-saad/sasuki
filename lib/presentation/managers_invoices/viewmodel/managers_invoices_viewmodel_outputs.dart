import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/domain/models/managers_invoices/managers_invoices.dart';

abstract class ManagersInvoicesViewModelOutputs {
  Stream<ManagersInvoices> get outputManagersInvoices;
}
