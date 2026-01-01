import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkProvider with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  NetworkProvider() {
    _initNetworkListener();
  }

  void _initNetworkListener() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      _isConnected = status == InternetConnectionStatus.connected;
      notifyListeners();
    });
  }

  Future<bool> checkConnection() async {
    _isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
    return _isConnected;
  }
}
