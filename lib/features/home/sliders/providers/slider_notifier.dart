import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/slider_repositories.dart';
import 'package:dristi_open_source/features/home/sliders/providers/slider_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliderNotifier extends Notifier<SliderState> {
  late SliderRepository repository;

  @override
  SliderState build() {
    repository = ref.read(sliderRepositoryProvider);
    return const SliderState();
  }

  Future<void> getSliderComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    try {
      state = state.copyWith(status: SliderStatus.loading);

      final response = await repository.getSliderComponents(
        appLanguage: appLanguage,
        isRefresh: isRefresh,
      );

      if (response.isNotEmpty) {
        state = state.copyWith(data: response, status: SliderStatus.success);
      } else {
        state = state.copyWith(status: SliderStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: SliderStatus.failure);
    }
  }
}
