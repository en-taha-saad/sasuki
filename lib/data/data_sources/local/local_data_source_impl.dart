import 'dart:convert';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/data/data_sources/local/local_data_source.dart';
import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';

import '../../../app/init_screens_dependencies/init_app_module.dart';

const storedListOfServers = "localStorageListOfServers";

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, ServersListResponse> storedMap = {};
  ServersListResponse? storedServersResponse;
  ServerResponse? selectedServer;
  final AppPreferences _appPrefs = instance<AppPreferences>();

  @override
  Future<ServersListResponse> getServersData() async {
    await _appPrefs.getListOfServers().then(
          (value) async => value != null
              ? getReadyServersList(value)
              : await createServersList(),
        );
    return Future.value(storedServersResponse);
  }

  Future<ServersListResponse?> getReadyServersList(String value) {
    storedMap = {
      storedListOfServers: ServersListResponse.fromJson(
        jsonDecode(value)[storedListOfServers],
      )
    };
    storedServersResponse = storedMap[storedListOfServers];
    return Future.value(storedServersResponse);
  }

  createServersList() async {
    storedMap = {
      storedListOfServers: storedServersResponse ?? ServersListResponse([])
      // storedListOfServers: ServersListResponse(Constants.dummyServersList)
    };
    await _appPrefs.setAddToServers(storedMap);
    final value = await _appPrefs.getListOfServers();
    storedServersResponse = value != null
        ? ServersListResponse.fromJson(jsonDecode(value)[storedListOfServers])
        : storedMap[storedListOfServers];
  }

  @override
  Future<bool?> removeServerFromShared(String serverName) async {
    bool isRemoved = false;
    storedServersResponse?.servers?.removeWhere((element) {
      isRemoved = element.name == serverName;
      return isRemoved;
    });
    await createServersList();
    return isRemoved;
  }

  @override
  Future<bool?> addServerToShared(ServerResponse? server) async {
    bool isAdded = false;
    storedServersResponse?.servers?.add(server!);
    storedServersResponse?.servers?.firstWhere((element) {
      isAdded = element.name == server?.name;
      return isAdded;
    });
    await createServersList();
    return isAdded;
  }

  @override
  saveSelectedServerToShared(ServerResponse serverResponse) async {
    selectedServer = serverResponse;
    await _appPrefs.setSelectedServer(selectedServer!);
  }

  @override
  Future<ServerResponse?> getSelectedServerFromShared() async {
    final value = await _appPrefs.getSelectedServer();
    selectedServer =
        value != null ? ServerResponse.fromJson(jsonDecode(value)) : null;
    return Future.value(selectedServer);
  }
}
