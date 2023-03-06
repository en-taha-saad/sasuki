import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/filter_lists_responses/profile_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';

extension ProfileListResponsesMapper on ProfileListResponses? {
  ProfileList toDomain() {
    return ProfileList(
      this?.i0.orZero() ?? Constants.zeroNum.toInt(),
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.data.map((profileData) => profileData.toDomain()).toList() ?? [],
    );
  }
}

extension ProfileDataResponsesMapper on ProfileDataResponses? {
  ProfileData toDomain() {
    return ProfileData(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.name.orEmpty() ?? Constants.emptyStr,
    );
  }
}
