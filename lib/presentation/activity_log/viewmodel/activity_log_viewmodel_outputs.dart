import 'package:sasuki/domain/models/activity_log_events/activity_log_events.dart';
import 'package:sasuki/domain/models/activity_log_list/activity_log_list.dart';

abstract class ActivityLogViewModelViewModelOutputs {
  Stream<ActivityLogList> get outputActivityLogListData;
  Stream<bool> get outputIsSearchInputValid;
  Stream<ActivityLogEvents> get outputActivityLogEvents;
}
