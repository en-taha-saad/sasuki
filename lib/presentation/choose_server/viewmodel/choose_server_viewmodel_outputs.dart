import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/models/choosing_server/servers.dart';

abstract class ChooseServerViewModelOutputs {
  // stream controller output
  Stream<ServersList> get outputGotListOfServers;
  Stream<bool?> get outputIsNotSelectedServer;
  Stream<Server?> get outputSelectedServer;
  Stream<bool> get outputIsSelectedServer;
}
