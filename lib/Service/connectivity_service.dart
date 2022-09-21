import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static ConnectivityService? _instance;

  late Connectivity connectivity;
  late Stream<ConnectivityResult> subscription;

  static ConnectivityService get instance =>
      _instance ?? ConnectivityService._init();
  ConnectivityService._init() {
    connectivity = Connectivity();
    subscription = connectivity.onConnectivityChanged;
  }
}
