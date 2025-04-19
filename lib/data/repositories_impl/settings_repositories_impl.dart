import 'package:dristi_open_source/data/data_sources/settings_data_sources.dart';
import 'package:dristi_open_source/domain/entities/settings_entity.dart';
import 'package:dristi_open_source/domain/repositories/settings_repositories.dart';

class SettingsRepositoryImp implements SettingsRepository {
  const SettingsRepositoryImp({required this.dataSource});

  final SettingsDataSource dataSource;

  @override
  Future<SettingsEntity> getSettingsComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final response = await dataSource.getSettingsComponents(
      appLanguage: appLanguage,
      isRefresh: isRefresh,
    );

    return response.settingsEntity;
  }
}
