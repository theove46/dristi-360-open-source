import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/accommodations_list_repositories.dart';
import 'package:dristi_open_source/features/accommodations_list/providers/accommodations_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccommodationsListNotifier extends Notifier<AccommodationsListState> {
  late AccommodationsListRepository repository;

  @override
  AccommodationsListState build() {
    repository = ref.read(accommodationsListRepositoryProvider);
    return const AccommodationsListState();
  }

  Future<void> getAccommodationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    try {
      state = state.copyWith(status: AccommodationsListStatus.loading);

      final response = await repository.getAccommodationsListComponents(
        appLanguage: appLanguage,
        isRefresh: isRefresh,
      );

      if (response.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: AccommodationsListStatus.success,
        );
      } else {
        state = state.copyWith(status: AccommodationsListStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: AccommodationsListStatus.failure);
    }
  }
}
