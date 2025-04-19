import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/settings_repositories.dart';
import 'package:dristi_open_source/features/settings/providers/settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends Notifier<SettingsState> {
  late SettingsRepository repository;

  @override
  SettingsState build() {
    repository = ref.read(settingsRepositoryProvider);
    return const SettingsState();
  }

  Future<void> getSettingsComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    try {
      state = state.copyWith(status: SettingsStatus.loading);

      final response = await repository.getSettingsComponents(
        appLanguage: appLanguage,
        isRefresh: isRefresh,
      );

      if (response.message.isNotEmpty) {
        state = state.copyWith(data: response, status: SettingsStatus.success);
      } else {
        state = state.copyWith(status: SettingsStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: SettingsStatus.failure);
    }
  }
}
