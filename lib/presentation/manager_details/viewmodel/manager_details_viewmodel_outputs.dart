import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';

abstract class ManagerDetailsViewModelOutputs {
  Stream<ManagerOverviewApi> get outputManagerOverviewApi;
}
