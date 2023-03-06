import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/extend_user_informs_responses/extend_user_informs_responses.dart';
import 'package:sasuki/domain/models/extend_user_informs/extend_user_informs.dart';

extension ExtendUserInformsResponsesMapper on ExtendUserInformsResponses? {
  ExtendUserInforms toDomain() {
    return ExtendUserInforms(
      this?.data.toDomain(),
      this?.status.orZero(),
    );
  }
}

extension ExtendUserResponseMapper on ExtendUserResponse? {
  ExtendUser toDomain() {
    return ExtendUser(
      // this?.remainingRxtx.orEmpty(),
      // this?.remainingRx.orEmpty(),
      // this?.remainingTx.orEmpty(),
      // this?.remainingUptime.orEmpty(),
      this?.expiration.orEmpty(),
      this?.profileName.orEmpty(),
      // this?.profileId.orZero(),
      this?.username.orEmpty(),
      this?.balance.orEmpty(),
      this?.userBalance.orEmpty(),
      // this?.rewardPointsBalance.orEmpty(),
      this?.rewardPoints.orZero(),
      // this?.requiredPoints.orZero(),
    );
  }
}
