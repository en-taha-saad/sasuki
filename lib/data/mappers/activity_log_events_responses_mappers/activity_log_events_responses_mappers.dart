import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/activity_log_events_responses/activity_log_events_responses.dart';
import 'package:sasuki/domain/models/activity_log_events/activity_log_events.dart';

extension ActivityLogEventsResponseMapper on ActivityLogEventsResponses? {
  ActivityLogEvents toDomain() {
    return ActivityLogEvents(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension ActivityLogEventResponseMapper on ActivityLogEventResponse? {
  ActivityLogEvent toDomain() {
    return ActivityLogEvent(
      this?.event.orEmpty() ?? Constants.emptyStr,
    );
  }
}
