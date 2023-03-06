import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sasuki/data/network/internet_checker/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImpl(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}
