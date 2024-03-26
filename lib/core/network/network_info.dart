import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> connected();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> connected() => connectionChecker.hasConnection;
}
