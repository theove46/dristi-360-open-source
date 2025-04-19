import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/district_repositories.dart';
import 'package:dristi_open_source/features/districts/providers/district_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DistrictNotifier extends Notifier<DistrictState> {
  late DistrictRepository repository;

  @override
  DistrictState build() {
    repository = ref.read(districtRepositoryProvider);
    return const DistrictState();
  }

  Future<void> getDistrictComponents(String appLanguage) async {
    try {
      final response = await repository.getDistrictComponents(appLanguage);

      if (response.$1.isEmpty) {
        state = state.copyWith(data: response.$2);
      } else {
        state = state.copyWith(status: DistrictStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: DistrictStatus.failure);
    }
  }
}
