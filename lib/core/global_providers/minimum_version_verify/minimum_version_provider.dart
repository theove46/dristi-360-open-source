import 'package:dristi_open_source/core/global_providers/minimum_version_verify/minimum_version_notifier.dart';
import 'package:dristi_open_source/core/global_providers/minimum_version_verify/minimum_version_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final minimumVersionProvider =
    NotifierProvider<MinimumVersionNotifier, MinimumVersionState>(
      MinimumVersionNotifier.new,
      name: 'minimumVersionProvider',
    );
