import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

//serves the ux
enum ConnectivityStatus { connected, disconnected }

class ConnectivityState {
  final ConnectivityStatus status;

  ConnectivityState(this.status);
}

final internetProvider = StateNotifierProvider<Internet, ConnectivityState>((ref) {
  return Internet(Connectivity(), ref);
});

class Internet extends StateNotifier<ConnectivityState> {
final Connectivity connectivity;

Internet(this.connectivity,  ref)
    : super(ConnectivityState(ConnectivityStatus.disconnected)) {
  checkConnectivity();

  connectivity.onConnectivityChanged.listen((result) {
    if (result.contains(ConnectivityResult.none)) {
      state = ConnectivityState(ConnectivityStatus.disconnected);
    } else {
      state = ConnectivityState(ConnectivityStatus.connected);
    }
  });
}

Future<void> checkConnectivity() async {
  var result = await connectivity.checkConnectivity();
  if (result.contains(ConnectivityResult.none)) {
    state = ConnectivityState(ConnectivityStatus.disconnected);
  } else {
    state = ConnectivityState(ConnectivityStatus.connected);
  }
}


}