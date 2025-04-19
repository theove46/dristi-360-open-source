import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/data_sources_impl/categories_data_source_impl.dart';
import 'package:dristi_open_source/data/response_models/categories_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesDataSourceProvider = Provider<CategoriesDataSource>((ref) {
  final cacheService = ref.read(cacheServiceProvider);

  return CategoriesDataSourceImp(cacheService: cacheService);
});

abstract class CategoriesDataSource {
  Future<CategoriesResponseModel> categoriesComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
