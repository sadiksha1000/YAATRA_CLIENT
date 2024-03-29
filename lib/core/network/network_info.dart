import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  DataConnectionChecker connectionChecker;
  NetworkInfoImpl({
    required this.connectionChecker,
  });

  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
