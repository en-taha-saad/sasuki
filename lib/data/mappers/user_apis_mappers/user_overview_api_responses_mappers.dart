import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_bool.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/user_details_responses/user_overview_api_responses.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';

extension UserOverviewApiResponseMapper on UserOverviewApiResponse? {
  UserOverviewApi toDomain() {
    return UserOverviewApi(
      this?.data.toDomain(),
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}

extension UserOverviewDataResponseMapper on UserOverviewDataResponse? {
  UserOverviewData toDomain() {
    return UserOverviewData(
      this?.username.orEmpty(),
      this?.parentUsername.orEmpty(),
      this?.profileName.orEmpty(),
      this?.profileId.orZero(),
      this?.expiration.orEmpty(),
      this?.status.orFalse(),
      // this?.createdAt.orEmpty(),
      // this?.createdBy.orEmpty(),
      // this?.balance.orZero(),
      this?.password.orEmpty(),
      this?.firstname.orEmpty(),
      this?.lastname.orEmpty(),
      this?.phone.orEmpty(),
      // this?.address.orEmpty(),
      // this?.city.orEmpty(),
      this?.email.orEmpty(),
      this?.remainingRx.orZero(),
      this?.remainingTx.orZero(),
      this?.remainingRxtx.orZero(),
      this?.remainingUptime.orZero(),
      // this?.nextProfileChange.orFalse(),
      // this?.pinTries.orZero(),
      this?.lastOnline.orEmpty(),
      // this?.addons.orEmptyStringList(),
    );
  }
}
