import 'package:dristi_open_source/core/global_providers/package_info/package_info_notifier.dart';
import 'package:dristi_open_source/core/global_providers/package_info/package_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final packageInfoProvider =
    NotifierProvider<PackageInfoNotifier, PackageInfoState>(
      PackageInfoNotifier.new,
      name: 'packageInfoProvider',
    );
