import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/manager_details_responses/manager_details_responses.dart';
import 'package:sasuki/domain/models/manager_details/manager_details.dart';

extension ManagerDetailsResponseMapper on ManagerDetailsResponses? {
  ManagerDetails toDomain() {
    return ManagerDetails(
      this?.data.toDomain(),
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}

extension ManagerDetailsDataResponseMapper on ManagerDetailsDataResponses? {
  ManagerDetailsData toDomain() {
    return ManagerDetailsData(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.username.orEmpty(),
      this?.enabled.orZero() ?? Constants.zeroNum.toInt(),
      this?.city.orEmpty(),
      this?.country.orEmpty(),
      this?.firstname.orEmpty(),
      this?.lastname.orEmpty(),
      this?.email.orEmpty(),
      this?.phone.orEmpty(),
      this?.company.orEmpty(),
      this?.address.orEmpty(),
      this?.balance.orZero() ?? Constants.zeroNum.toInt(),
      this?.notes.orEmpty(),
      this?.managerId.orZero() ?? Constants.zeroNum.toInt(),
      this?.maxUsers.orZero() ?? Constants.zeroNum.toInt(),
      this?.createdAt.orEmpty(),
      this?.deletedAt.orEmpty(),
      this?.aclGroupId.orZero() ?? Constants.zeroNum.toInt(),
      this?.parentId.orZero() ?? Constants.zeroNum.toInt(),
      this?.createdBy.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}
