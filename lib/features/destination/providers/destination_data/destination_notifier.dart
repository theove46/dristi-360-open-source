import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/destination_repositories.dart';
import 'package:dristi_open_source/features/destination/providers/destination_data/destination_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DestinationNotifier extends Notifier<DestinationState> {
  late DestinationRepository repository;

  @override
  DestinationState build() {
    repository = ref.read(destinationRepositoryProvider);
    return const DestinationState();
  }

  Future<void> getDestinationData(String appLanguage, String id) async {
    try {
      state = state.copyWith(status: DestinationStatus.loading);

      final response = await repository.getDestinationData(appLanguage, id);

      if (response.id.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: DestinationStatus.success,
        );
      } else {
        state = state.copyWith(status: DestinationStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: DestinationStatus.failure);
    }
  }
}
