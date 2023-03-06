import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';

extension ServerResponseMapper on ServerResponse? {
  Server toDomain() {
    return Server(
      this?.name.orEmpty() ?? Constants.emptyStr,
      this?.hostName.orEmpty() ?? Constants.emptyStr,
      this?.username.orEmpty() ?? Constants.emptyStr,
      this?.password.orEmpty() ?? Constants.emptyStr,
    );
  }
}
