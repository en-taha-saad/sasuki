import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/manager_details_responses/manager_overview_api_responses.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';

extension ManagerOverviewApiResponseMapper on ManagerOverviewApiResponses? {
  ManagerOverviewApi toDomain() {
    return ManagerOverviewApi(
      this?.data.toDomain(),
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}

extension ManagerOverviewDataResponseMapper on ManagerOverviewDataResponse? {
  ManagerOverviewData toDomain() {
    return ManagerOverviewData(
      this?.username.orEmpty() ?? Constants.dash,
      this?.firstname.orEmpty() ?? Constants.dash,
      this?.lastname.orEmpty() ?? Constants.dash,
      this?.aclGroupName.orEmpty() ?? Constants.dash,
      this?.createdAt.orEmpty() ?? Constants.dash,
      this?.balance.orZero() ?? Constants.zeroNum.toInt(),
      this?.rewardPoints.orZero() ?? Constants.zeroNum.toInt(),
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.users.orZero() ?? Constants.zeroNum.toInt(),
      this?.activeUsers.orZero() ?? Constants.zeroNum.toInt(),
      this?.expiredUsers.orZero() ?? Constants.zeroNum.toInt(),
      this?.phone.orEmpty() ?? Constants.dash,
      this?.parentUsername.orEmpty() ?? Constants.dash,
      this?.debts.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}
