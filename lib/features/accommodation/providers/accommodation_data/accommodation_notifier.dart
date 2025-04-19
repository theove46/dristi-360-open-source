import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/accommodation_repositories.dart';
import 'package:dristi_open_source/features/accommodation/providers/accommodation_data/accommodation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccommodationNotifier extends Notifier<AccommodationState> {
  late AccommodationRepository repository;

  @override
  AccommodationState build() {
    repository = ref.read(accommodationRepositoryProvider);
    return const AccommodationState();
  }

  Future<void> getAccommodationData(String appLanguage, String id) async {
    try {
      state = state.copyWith(status: AccommodationStatus.loading);

      final response = await repository.getAccommodationData(appLanguage, id);

      if (response.id.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: AccommodationStatus.success,
        );
      } else {
        state = state.copyWith(status: AccommodationStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: AccommodationStatus.failure);
    }
  }
}
