import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/user_action_response/user_action_response.dart';
import 'package:sasuki/domain/models/user_action/edit_user.dart';
import 'package:sasuki/domain/models/user_action/user_action.dart';

extension UserActionResponseMapper on UserActionResponse? {
  UserAction toDomain() {
    return UserAction(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.message.orEmpty() ?? Constants.emptyStr,
    );
  }
}

extension EditUserResponseMapper on EditUserResponse? {
  EditUser toDomain() {
    return EditUser(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}
