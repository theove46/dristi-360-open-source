import 'package:dristi_open_source/core/global_providers/minimum_version_verify/minimum_version_state.dart';
import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/on_boarding_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MinimumVersionNotifier extends Notifier<MinimumVersionState> {
  late OnBoardingRepository repository;

  @override
  MinimumVersionState build() {
    repository = ref.read(onBoardingRepositoryProvider);
    return const MinimumVersionState();
  }

  Future<void> fetchMinimumVersionRequired() async {
    try {
      state = state.copyWith(status: MinimumVersionStatus.loading);

      final response = await repository.fetchMinimumVersionRequired();

      if (response.minVersion.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: MinimumVersionStatus.success,
        );
      } else {
        state = state.copyWith(status: MinimumVersionStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: MinimumVersionStatus.failure);
    }
  }
}
