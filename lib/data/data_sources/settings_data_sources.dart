import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/data_sources_impl/settings_data_sources_impl.dart';
import 'package:dristi_open_source/data/response_models/settings_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsDataSourceProvider = Provider<SettingsDataSource>((ref) {
  final cacheService = ref.read(cacheServiceProvider);
  return SettingsDataSourceImp(cacheService: cacheService);
});

abstract class SettingsDataSource {
  Future<SettingsResponseModel> getSettingsComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
