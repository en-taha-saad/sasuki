import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';

abstract class LocalDataSource {
  Future<ServersListResponse> getServersData();

  Future<bool?> removeServerFromShared(String serverName);
  Future addServerToShared(ServerResponse? server);

  void saveSelectedServerToShared(ServerResponse serverResponse);
  Future<ServerResponse?> getSelectedServerFromShared();
}
