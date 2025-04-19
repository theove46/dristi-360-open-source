import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/top_destinations_repositories.dart';
import 'package:dristi_open_source/features/home/top_destinations/providers/top_destinations_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopDestinationsNotifier extends Notifier<TopDestinationsState> {
  late TopDestinationsRepository repository;

  @override
  TopDestinationsState build() {
    repository = ref.read(topDestinationsRepositoryProvider);
    return const TopDestinationsState();
  }

  Future<void> topDestinationsComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    try {
      state = state.copyWith(status: TopDestinationsStatus.loading);

      final response = await repository.getTopDestinationsComponents(
        appLanguage: appLanguage,
        isRefresh: isRefresh,
      );

      if (response.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: TopDestinationsStatus.success,
        );
      } else {
        state = state.copyWith(status: TopDestinationsStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: TopDestinationsStatus.failure);
    }
  }
}
