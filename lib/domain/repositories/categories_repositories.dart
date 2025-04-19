import 'package:dristi_open_source/data/data_sources/categories_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/categories_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/categories_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final dataSource = ref.read(categoriesDataSourceProvider);
  return CategoriesRepositoryImp(dataSource: dataSource);
});

abstract class CategoriesRepository {
  Future<List<CategoryEntity>> getCategoriesComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
