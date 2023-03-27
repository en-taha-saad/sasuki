import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_bool.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/users_list_responses/users_list_responses.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';

extension UsersListResponseMapper on UsersListResponse? {
  UsersList toDomain() {
    return UsersList(
      // this?.currentPage.orZero() ?? Constants.zeroNum.toInt(),
      this?.data?.map((usersListData) => usersListData.toDomain()).toList(),
      // this?.firstPageUrl.orEmpty() ?? Constants.emptyStr,
      // this?.from.orZero() ?? Constants.zeroNum.toInt(),
      // this?.lastPage.orZero() ?? Constants.zeroNum.toInt(),
      // this?.lastPageUrl.orEmpty() ?? Constants.emptyStr,
      // this?.nextPageUrl.orEmpty() ?? Constants.emptyStr,
      // this?.path.orEmpty() ?? Constants.emptyStr,
      // this?.perPage.orZero() ?? Constants.zeroNum.toInt(),
      // this?.to.orZero() ?? Constants.zeroNum.toInt(),
      this?.total.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}

extension UsersListDataResponseMapper on UsersListDataResponse? {
  UsersListData toDomain() {
    return UsersListData(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.username.orEmpty() ?? Constants.emptyStr,
      this?.firstname.orEmpty() ?? Constants.emptyStr,
      this?.lastname.orEmpty() ?? Constants.emptyStr,
      // this?.city.orEmpty() ?? Constants.emptyStr,
      // this?.phone.orEmpty() ?? Constants.emptyStr,
      // this?.profileId.orZero() ?? Constants.zeroNum.toInt(),
      this?.balance.orEmpty() ?? Constants.emptyStr,
      this?.expiration.orEmpty() ?? Constants.emptyStr,
      // this?.parentId.orZero() ?? Constants.zeroNum.toInt(),
      this?.enabled.orZero() ?? Constants.zeroNum.toInt(),
      this?.notes.orEmpty() ?? Constants.emptyStr,
      // this?.simultaneousSessions.orZero() ?? Constants.zeroNum.toInt(),
      // this?.address.orEmpty() ?? Constants.emptyStr,
      // this?.contractId.orEmpty() ?? Constants.emptyStr,
      // this?.createdAt.orEmpty() ?? Constants.emptyStr,
      // this?.groupId.orZero() ?? Constants.zeroNum.toInt(),
      // this?.nRow.orZero() ?? Constants.zeroNum.toInt(),
      this?.status.toDomain(),
      this?.onlineStatus.orZero() ?? Constants.zeroNum.toInt(),
      // this?.parentUsername.orEmpty() ?? Constants.emptyStr,
      this?.profileDetails.toDomain(),
      // this?.groupDetails.toDomain(),
    );
  }
}

extension StatusResponsesMapper on StatusResponses? {
  Status toDomain() {
    return Status(
      this?.status.orFalse() ?? Constants.falseBool,
      // this?.traffic.orFalse() ?? Constants.falseVal,
      // this?.expiration.orFalse() ?? Constants.falseVal,
      // this?.uptime.orFalse() ?? Constants.falseVal,
    );
  }
}

extension ProfileDetailsResponsesMapper on ProfileDetailsResponses? {
  ProfileDetails toDomain() {
    return ProfileDetails(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.name.orEmpty() ?? Constants.emptyStr,
      this?.type.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}

extension GroupDetailsResponsesMapper on GroupDetailsResponses? {
  GroupDetails toDomain() {
    return GroupDetails(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.groupName.orEmpty() ?? Constants.emptyStr,
    );
  }
}
