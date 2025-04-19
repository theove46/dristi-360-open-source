import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/domain/repositories/app_repositories.dart';

class AppRepositoryImp implements AppRepository {
  const AppRepositoryImp({required this.cacheService});

  final CacheService cacheService;

  @override
  Future<AppTheme> loadInitialThemeState() async {
    final theme = await cacheService.getTheme();

    return theme;
  }

  @override
  void setTheme(AppTheme theme) {
    cacheService.setTheme(theme);
  }

  @override
  Future<AppLanguages> loadInitialLanguageState() {
    final language = cacheService.getLanguage();

    return language;
  }

  @override
  void setLanguage(AppLanguages language) {
    cacheService.setLanguage(language);
  }
}
