import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  void onInternetChange({
    required void Function() onConnect,
    required void Function() onDisconnect,
  }) {}
}

@LazySingleton(as: NetworkInfo)
final class NetworkInfoImpl implements NetworkInfo {
  @factoryMethod
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker();

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  void onInternetChange({
    required void Function() onConnect,
    required void Function() onDisconnect,
  }) {
    connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        onConnect();
      } else {
        onDisconnect();
      }
    });
  }
}
