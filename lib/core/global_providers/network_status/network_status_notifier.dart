import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_state.dart';
import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkStatusNotifier extends Notifier<NetworkState> {
  @override
  NetworkState build() {
    _initConnectivity();
    return const NetworkState();
  }

  Future<void> _initConnectivity() async {
    List<ConnectivityResult> result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (error, stackTrace) {
      Log.error(error.toString());
      Log.error(stackTrace.toString());
      return;
    }

    updateConnectionStatus(result);

    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      updateConnectionStatus(result);
    });
  }

  void updateConnectionStatus(List<ConnectivityResult> result) {
    state = state.copyWith(value: result, status: NetworkStatus.success);
  }
}
