import 'package:dristi_open_source/core/global_providers/package_info/package_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoNotifier extends Notifier<PackageInfoState> {
  @override
  PackageInfoState build() {
    return const PackageInfoState();
  }

  Future<void> loadPackageInfoState() async {
    state = state.copyWith(status: PackageInfoStatus.loading);

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      state = state.copyWith(
        data: packageInfo,
        status: PackageInfoStatus.success,
      );
    } catch (e) {
      state = state.copyWith(status: PackageInfoStatus.failure);
    }
  }
}
