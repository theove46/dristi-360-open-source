import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/repositories_impl/app_repositories_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRepositoryProvider = Provider<AppRepository>((ref) {
  final cacheService = ref.read(cacheServiceProvider);

  return AppRepositoryImp(cacheService: cacheService);
});

abstract class AppRepository {
  Future<AppTheme> loadInitialThemeState();

  void setTheme(AppTheme theme);

  Future<AppLanguages> loadInitialLanguageState();

  void setLanguage(AppLanguages language);
}
