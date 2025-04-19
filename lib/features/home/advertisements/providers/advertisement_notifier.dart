import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/advertisement_repositories.dart';
import 'package:dristi_open_source/features/home/advertisements/providers/advertisement_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvertisementNotifier extends Notifier<AdvertisementState> {
  late AdvertisementRepository repository;

  @override
  AdvertisementState build() {
    repository = ref.read(advertisementRepositoryProvider);
    return const AdvertisementState();
  }

  Future<void> getSingleAdvertisementComponents() async {
    try {
      state = state.copyWith(status: AdvertisementStatus.loading);

      final response = await repository.getSingleAdvertisementComponents();

      if (response.image.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: AdvertisementStatus.success,
        );
      } else {
        state = state.copyWith(status: AdvertisementStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: AdvertisementStatus.failure);
    }
  }

  Future<void> getMultipleAdvertisementComponents() async {
    try {
      state = state.copyWith(status: AdvertisementStatus.loading);

      final response = await repository.getMultipleAdvertisementComponents();

      if (response.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: AdvertisementStatus.success,
        );
      } else {
        state = state.copyWith(status: AdvertisementStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: AdvertisementStatus.failure);
    }
  }
}
