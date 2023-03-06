import 'package:sasuki/data/mappers/serversList_mappers/server_response_mapper.dart';
import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/models/choosing_server/servers.dart';

extension ServersListResponseMapper on ServersListResponse? {
  ServersList toDomain() {
    List<Server> servers = (this?.servers?.map(
                  (serverResponse) => serverResponse.toDomain(),
                ) ??
            const Iterable.empty())
        .cast<Server>()
        .toList();

    return ServersList(servers);
  }
}
