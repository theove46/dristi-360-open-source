import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/data_sources_impl/popular_districts_data_source_impl.dart';
import 'package:dristi_open_source/data/response_models/popular_districts_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularDistrictDataSourceProvider = Provider<PopularDistrictDataSource>((
  ref,
) {
  final cacheService = ref.read(cacheServiceProvider);
  return PopularDistrictDataSourceImp(cacheService: cacheService);
});

abstract class PopularDistrictDataSource {
  Future<PopularDistrictsResponseModel> popularDistrictComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
