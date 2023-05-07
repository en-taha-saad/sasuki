import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/activity_log_list_responses/activity_log_list_responses.dart';
import 'package:sasuki/domain/models/activity_log_list/activity_log_list.dart';

extension ActivityLogListResponseMapper on ActivityLogListResponses? {
  ActivityLogList toDomain() {
    return ActivityLogList(
      this?.data?.map((e) => e?.toDomain()).toList() ?? [],
      this?.total.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}

extension ActivityLogResMapper on ActivityLogRes? {
  ActivityLog toDomain() {
    return ActivityLog(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.createdAt.orEmpty() ?? Constants.emptyStr,
      this?.createdBy.orZero() ?? Constants.zeroNum.toInt(),
      this?.event.orEmpty() ?? Constants.emptyStr,
      this?.description.orEmpty() ?? Constants.emptyStr,
      this?.ip.orEmpty() ?? Constants.emptyStr,
      this?.managerDetails.toDomain(),
    );
  }
}

extension ManagerDetailsResMapper on ManagerDetailsRes? {
  ManagerDetails toDomain() {
    return ManagerDetails(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.username.orEmpty() ?? Constants.emptyStr,
      this?.firstName.orEmpty() ?? Constants.emptyStr,
      this?.lastName.orEmpty() ?? Constants.emptyStr,
    );
  }
}
