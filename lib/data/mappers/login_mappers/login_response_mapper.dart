import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/login_responses/login_responses.dart';
import 'package:sasuki/domain/models/login/login.dart';

extension LoginResponseMapper on LoginResponse? {
  Login toDomain() {
    return Login(
      this?.status.orZero() ?? Constants.zeroNum.toInt(),
      this?.token.orEmpty() ?? Constants.emptyStr,
    );
  }
}
