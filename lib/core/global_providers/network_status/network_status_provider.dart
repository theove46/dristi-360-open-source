import 'package:dristi_open_source/core/global_providers/network_status/network_status_notifier.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkStatusProvider =
    NotifierProvider<NetworkStatusNotifier, NetworkState>(
  NetworkStatusNotifier.new,
  name: 'networkStatusProvider',
);
