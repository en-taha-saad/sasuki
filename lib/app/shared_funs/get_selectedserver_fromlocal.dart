import 'dart:convert';

import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/data/mappers/serversList_mappers/server_response_mapper.dart';
import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';

Future<Server> getSelectedServerFromLocal() async {
  final savedServer = (await instance<AppPreferences>().getSelectedServer());
  Server? server;
  if (savedServer != null) {
    server = ServerResponse.fromJson(jsonDecode(savedServer)).toDomain();
    return server;
  } else {
    return Server(
      Constants.defaultServerName,
      Constants.serverAddress,
      Constants.emptyStr,
      Constants.emptyStr,
    );
  }
}
