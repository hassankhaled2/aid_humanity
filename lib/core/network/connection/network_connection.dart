import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnctionInfo {
  Future<bool> get isConnected;
}


class ConnectionInfoImpl implements ConnctionInfo {
  InternetConnectionChecker internetConnectionChecker;
  ConnectionInfoImpl({
    required this.internetConnectionChecker,
  });
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
