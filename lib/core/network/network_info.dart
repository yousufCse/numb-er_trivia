import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnection;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker checker;

  const NetworkInfoImpl({required this.checker});

  @override
  Future<bool> get isConnection => checker.hasConnection;
}
