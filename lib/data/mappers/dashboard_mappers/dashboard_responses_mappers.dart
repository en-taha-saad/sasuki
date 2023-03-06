import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_double.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/app/extensions/non_null_string_list.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/dashboard/client_res.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/dashboard/dashboard_data.dart';

import '../../responses/dashboard_responses/auth_responses.dart';
import '../../responses/dashboard_responses/dashboard_data_responses.dart';

extension AuthResponsesMapper on AuthResponses? {
  Auth toDomain() {
    return Auth(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.client.toDomain(),
      this?.permissions.orEmptyStringList() ?? Constants.emptyList,
      // this?.features.orEmptyStringList() ?? Constants.emptyList,
      // this?.licenseStatus.orEmpty() ?? Constants.emptyStr,
      // this?.licenseExpiration.orEmpty() ?? Constants.emptyStr,
    );
  }
}

extension ClientResponseMapper on ClientResponse? {
  ClientRes toDomain() {
    return ClientRes(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.username.orEmpty() ?? Constants.emptyStr,
      // this?.enabled.orZero() ?? Constants.zeroNum.toInt(),
      // this?.city.orEmpty() ?? Constants.emptyStr,
      // this?.country.orEmpty() ?? Constants.emptyStr,
      this?.firstname.orEmpty() ?? Constants.emptyStr,
      this?.lastname.orEmpty() ?? Constants.emptyStr,
      // this?.email.orEmpty() ?? Constants.emptyStr,
      // this?.phone.orEmpty() ?? Constants.emptyStr,
      // this?.company.orEmpty() ?? Constants.emptyStr,
      // this?.address.orEmpty() ?? Constants.emptyStr,
      this?.balance.orZeroDouble() ?? 0,
      // this?.loanBalance.orEmpty() ?? Constants.emptyStr,
      // this?.debtLimit.orEmpty() ?? Constants.emptyStr,
      // this?.subscriberSuffix.orEmpty() ?? Constants.emptyStr,
      // this?.subscriberPrefix.orEmpty() ?? Constants.emptyStr,
      // this?.notes.orEmpty() ?? Constants.emptyStr,
      // this?.managerId.orZero() ?? Constants.zeroNum.toInt(),
      // this?.mobileAuthSecret.orEmpty() ?? Constants.emptyStr,
      // this?.maxUsers.orEmpty() ?? Constants.emptyStr,
      // this?.mikrotikAddresslist.orEmpty() ?? Constants.emptyStr,
      // this?.createdAt.orEmpty() ?? Constants.emptyStr,
      // this?.updatedAt.orEmpty() ?? Constants.emptyStr,
      // this?.deletedAt.orEmpty() ?? Constants.emptyStr,
      // this?.aclGroupId.orZero() ?? Constants.zeroNum.toInt(),
      // this?.siteId.orEmpty() ?? Constants.emptyStr,
      // this?.avatar.orEmpty() ?? Constants.emptyStr,
      // this?.parentId.orZero() ?? Constants.zeroNum.toInt(),
      // this?.createdBy.orZero() ?? Constants.zeroNum.toInt(),
      // this?.rewardPoints.orZero() ?? Constants.zeroNum.toInt(),
      // this?.discountRate.orEmpty() ?? Constants.emptyStr,
      // this?.adminNotes.orEmpty() ?? Constants.emptyStr,
      // this?.limitDelete.orZero() ?? Constants.zeroNum.toInt(),
      // this?.limitDeleteCount.orZero() ?? Constants.zeroNum.toInt(),
      // this?.limitRename.orZero() ?? Constants.zeroNum.toInt(),
      // this?.limitRenameCount.orZero() ?? Constants.zeroNum.toInt(),
      // this?.limitProfileChange.orZero() ?? Constants.zeroNum.toInt(),
      // this?.limitProfileChangeCount.orZero() ?? Constants.zeroNum.toInt(),
      // this?.limitMacChange.orZero() ?? Constants.zeroNum.toInt(),
      // this?.limitMacChangeCount.orZero() ?? Constants.zeroNum.toInt(),
      // this?.requires2fa.orZero() ?? Constants.zeroNum.toInt(),
      // this?.groupId.orEmpty() ?? Constants.emptyStr,
      // this?.forceChangePassword.orZero() ?? Constants.zeroNum.toInt(),
      // this?.avatarData.orEmpty() ?? Constants.emptyStr,
    );
  }
}

extension DashboardResponseMapper on DashboardResponse? {
  Dashboard toDomain() {
    return Dashboard(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.data.toDomain(),
    );
  }
}

extension DashboardDataResponseMapper on DashboardDataResponse? {
  DashboardData toDomain() {
    return DashboardData(
      this?.usersCount.orZero() ?? Constants.zeroNum.toInt(),
      this?.usersOnlineCount.orZero() ?? Constants.zeroNum.toInt(),
      this?.activeUsersCount.orZero() ?? Constants.zeroNum.toInt(),
      this?.expiredUsersCount.orZero() ?? Constants.zeroNum.toInt(),
      this?.expiringSoonCount.orZero() ?? Constants.zeroNum.toInt(),
      this?.balance.orZeroDouble() ?? 0,
      this?.rewardPointsBalance.orZero() ?? Constants.zeroNum.toInt(),
      this?.registredToday.orZero() ?? Constants.zeroNum.toInt(),
      this?.activationsToday.orZero() ?? Constants.zeroNum.toInt(),
      this?.salesToday.orZero() ?? Constants.zeroNum.toInt(),
      this?.profitsToday.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}
