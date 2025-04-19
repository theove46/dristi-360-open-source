import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/popular_districts_repositories.dart';
import 'package:dristi_open_source/features/home/popular_districts/providers/popular_districts_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularDistrictNotifier extends Notifier<PopularDistrictState> {
  late PopularDistrictRepository repository;

  @override
  PopularDistrictState build() {
    repository = ref.read(popularDistrictRepositoryProvider);
    return const PopularDistrictState();
  }

  Future<void> getPopularDistrictComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    try {
      state = state.copyWith(status: PopularDistrictsStatus.loading);

      final response = await repository.getPopularDistrictComponents(
        appLanguage: appLanguage,
        isRefresh: isRefresh,
      );

      if (response.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: PopularDistrictsStatus.success,
        );
      } else {
        state = state.copyWith(status: PopularDistrictsStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: PopularDistrictsStatus.failure);
    }
  }
}
