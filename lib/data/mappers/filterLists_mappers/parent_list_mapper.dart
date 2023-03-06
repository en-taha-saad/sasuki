import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/filter_lists_responses/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';

extension SingleParentDataResponsesMapper on SingleParentDataResponses? {
  SingleParentData toDomain() {
    return SingleParentData(
      this?.id.orZero() ?? Constants.zeroNum.toInt(),
      this?.parentId.orZero() ?? Constants.zeroNum.toInt(),
      this?.username.orEmpty() ?? Constants.emptyStr,
    );
  }
}
