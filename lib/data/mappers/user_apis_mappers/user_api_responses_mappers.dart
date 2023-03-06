import 'package:sasuki/app/extensions/non_null_bool.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/user_details_responses/user_api_responses.dart';
import 'package:sasuki/domain/models/user_details/user_api.dart';

extension UserApiResponseMapper on UserApiResponse? {
  UserApi toDomain() {
    return UserApi(
      this?.data.toDomain(),
      this?.status.orZero(),
    );
  }
}

extension UserDataResponseMapper on UserDataResponse? {
  UserData toDomain() {
    return UserData(
      this?.id.orZero(),
      this?.username.orEmpty(),
      this?.profileId.orZero(),
      this?.enabled.orZero(),
      this?.expiration.orEmpty(),
      this?.address.orEmpty(),
      this?.city.orEmpty(),
      this?.country.orEmpty(),
      this?.macAuth.orZero(),
      this?.staticIp.orEmpty(),
      this?.groupId.orZero(),
      this?.service.orEmpty(),
      this?.firstname.orEmpty(),
      this?.lastname.orEmpty(),
      this?.email.orEmpty(),
      this?.phone.orEmpty(),
      this?.company.orEmpty(),
      this?.apartment.orEmpty(),
      this?.street.orEmpty(),
      this?.contractId.orZero(),
      this?.parentId.orZero(),
      this?.createdAt.orEmpty(),
      this?.updatedAt.orEmpty(),
      this?.deletedAt.orEmpty(),
      this?.lastIpAddress.orEmpty(),
      this?.lastOnline.orEmpty(),
      this?.userType.orZero(),
      this?.createdBy.orEmpty(),
      this?.nationalId.orZero(),
      this?.simultaneousSessions.orZero(),
      this?.mikrotikWinboxGroup.orEmpty(),
      this?.mikrotikFramedRoute.orEmpty(),
      this?.mikrotikAddresslist.orEmpty(),
      this?.mikrotikIpv6Prefix.orEmpty(),
      this?.balance.orEmpty(),
      this?.loanBalance.orEmpty(),
      this?.notes.orEmpty(),
      this?.picture.orEmpty(),
      this?.pinTries.orZero(),
      this?.siteId.orZero(),
      this?.gpsLat.orEmpty(),
      this?.gpsLng.orEmpty(),
      this?.lastProfileId.orZero(),
      this?.autoRenew.orZero(),
      this?.useSeparatePortalPassword.orZero(),
      this?.restricted.orZero(),
      this?.profileName.orEmpty(),
      this?.status.toDomain(),
      this?.profileChange.orFalse(),
      this?.parentUsername.orEmpty(),
    );
  }
}

extension UserDataStatusResponseMapper on UserDataStatusResponse? {
  UserDataStatus toDomain() {
    return UserDataStatus(
      this?.status.orFalse(),
      this?.traffic.orFalse(),
      this?.expiration.orFalse(),
      this?.uptime.orFalse(),
    );
  }
}
