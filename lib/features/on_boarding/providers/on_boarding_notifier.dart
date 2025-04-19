import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/on_boarding_repository.dart';
import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingNotifier extends Notifier<OnBoardingState> {
  late OnBoardingRepository repository;

  @override
  OnBoardingState build() {
    repository = ref.read(onBoardingRepositoryProvider);
    return const OnBoardingState();
  }

  Future<bool> getFirstTimeStatus() async {
    try {
      final response = await repository.getFirstTimeStatus();

      return response;
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      return true;
    }
  }

  Future<void> homeScreenNavigationSubmit() async {
    try {
      state = state.copyWith(status: OnBoardingStatus.loading);

      final response = await repository.buttonSubmit();
      await repository.setFirstTimeStatusFalse();

      if (response.$1.isEmpty) {
        state = state.copyWith(
          status: OnBoardingStatus.success,
        );
      } else {
        state = state.copyWith(
          status: OnBoardingStatus.failure,
        );
      }
    } catch (e, stackTrace) {
      Log.debug(stackTrace.toString());
      state = state.copyWith(
        status: OnBoardingStatus.failure,
      );
    }
  }
}
