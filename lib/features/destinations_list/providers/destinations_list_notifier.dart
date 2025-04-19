import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/destinations_list_repositories.dart';
import 'package:dristi_open_source/features/destinations_list/providers/destinations_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DestinationsListNotifier extends Notifier<DestinationsListState> {
  late DestinationsListRepository repository;

  @override
  DestinationsListState build() {
    repository = ref.read(destinationsListRepositoryProvider);
    return const DestinationsListState();
  }

  Future<void> getDestinationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    try {
      state = state.copyWith(status: DestinationListStatus.loading);

      final response = await repository.getDestinationsListComponents(
        appLanguage: appLanguage,
        isRefresh: isRefresh,
      );

      if (response.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: DestinationListStatus.success,
        );
      } else {
        state = state.copyWith(status: DestinationListStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: DestinationListStatus.failure);
    }
  }
}
