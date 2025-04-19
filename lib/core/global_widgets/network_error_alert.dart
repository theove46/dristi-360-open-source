import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/styles/colors/colors.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkErrorAlert extends ConsumerStatefulWidget {
  const NetworkErrorAlert({super.key});

  @override
  ConsumerState createState() => _NetworkErrorAlertState();
}

class _NetworkErrorAlertState
    extends BaseConsumerStatefulWidget<NetworkErrorAlert> {
  late StreamSubscription<List<ConnectivityResult>> networkConnectivity;

  @override
  void initState() {
    super.initState();
    networkConnectivity = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      ref.read(networkStatusProvider.notifier).updateConnectionStatus(result);
    });
  }

  @override
  void dispose() {
    networkConnectivity.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(networkStatusProvider);

    if (state.data?.first == ConnectivityResult.none) {
      return Column(
        children: [
          Container(
            height: AppValues.dimen_16.h,
            width: double.infinity,
            color: UIColors.errorText(context),
            child: Center(
              child: Text(
                context.localization.noNetwork,
                style: appTextStyles.onImageNovaRegular8,
              ),
            ),
          ),
          SizedBox(height: AppValues.dimen_4.h),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
