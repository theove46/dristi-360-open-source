import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:dristi_open_source/core/global_providers/theme_settings/theme_settings_state.dart';
import 'package:dristi_open_source/domain/repositories/app_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<ThemeState> {
  late AppRepository repository;

  @override
  ThemeState build() {
    repository = ref.read(appRepositoryProvider);
    return const ThemeState();
  }

  Future<void> loadInitialThemeState() async {
    final theme = await repository.loadInitialThemeState();

    state = state.copyWith(data: theme);
  }

  void setTheme(AppTheme theme) {
    repository.setTheme(theme);

    state = state.copyWith(data: theme);
  }
}
