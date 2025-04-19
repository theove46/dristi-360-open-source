import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/destination_repositories.dart';
import 'package:dristi_open_source/features/destination/providers/destination_items/destination_item_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DestinationItemsNotifier extends Notifier<DestinationItemsState> {
  late DestinationRepository repository;

  @override
  DestinationItemsState build() {
    repository = ref.read(destinationRepositoryProvider);
    return const DestinationItemsState();
  }

  Future<void> getDestinationItems(String appLanguage) async {
    try {
      final response = await repository.getDestinationItems(appLanguage);

      if (response.$1.isEmpty) {
        state = state.copyWith(data: response.$2);
      } else {
        state = state.copyWith(status: DestinationItemsStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: DestinationItemsStatus.failure);
    }
  }
}
