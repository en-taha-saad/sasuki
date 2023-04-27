import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';

abstract class ReportsActivationsViewModelOutputs {
  Stream<ActivationsReports> get outputReportsActivations;
  Stream<List<ProfileData>> get outputProfileList;
}
