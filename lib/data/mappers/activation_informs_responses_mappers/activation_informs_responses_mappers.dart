import 'package:sasuki/app/extensions/non_null_double.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/activation_informs_responses/activation_informs_responses.dart';
import 'package:sasuki/domain/models/activation_informs/activation_informs.dart';

extension ActivationInformsResponseMapper on ActivationInformsResponse? {
  ActivationInforms toDomain() {
    return ActivationInforms(
      this?.data.toDomain(),
      this?.status.orZero(),
    );
  }
}

extension ActivationInformsDataResponseMapper
    on ActivationInformsDataResponse? {
  ActivationInformsData toDomain() {
    return ActivationInformsData(
      // this?.username.orEmpty(),
      // this?.profileName.orEmpty(),
      // this?.profileId.orZero(),
      // this?.parentId.orZero(),
      this?.managerBalance.orEmpty(),
      this?.userBalance.orEmpty(),
      // this?.userExpiration.orEmpty(),
      this?.unitPrice.orEmpty(),
      this?.userPrice.orZeroDouble() ?? 0,
      // this?.profileDuration.orEmpty(),
      // this?.profileTraffic.orEmpty(),
      // this?.profileDlTraffic.orEmpty(),
      // this?.profileUlTraffic.orEmpty(),
      // this?.profileDescription.orEmpty(),
      // this?.vat.orEmpty(),
      // this?.units.orZero(),
      // this?.requiredAmount.orEmpty(),
      // this?.nRequiredAmount.orZero(),
      // this?.rewardPoints.orZero(),
      // this?.requiredPoints.orZero(),
      // this?.rewardPointsBalance.orZero(),
    );
  }
}
