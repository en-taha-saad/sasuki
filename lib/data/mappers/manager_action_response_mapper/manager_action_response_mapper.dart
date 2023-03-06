import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/data/responses/manager_action_response/manager_action_response.dart';
import 'package:sasuki/domain/models/manager_action/manager_action.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';

extension ManagerActionResponseMapper on ManagerActionResponse? {
  ManagerAction toDomain() {
    return ManagerAction(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.error.orEmpty() ?? Constants.emptyStr,
    );
  }
}
