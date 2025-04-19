import 'package:dristi_open_source/data/data_sources/categories_data_source.dart';
import 'package:dristi_open_source/domain/entities/categories_entity.dart';
import 'package:dristi_open_source/domain/repositories/categories_repositories.dart';

class CategoriesRepositoryImp implements CategoriesRepository {
  const CategoriesRepositoryImp({required this.dataSource});

  final CategoriesDataSource dataSource;

  @override
  Future<List<CategoryEntity>> getCategoriesComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final response = await dataSource.categoriesComponents(
      appLanguage: appLanguage,
      isRefresh: isRefresh,
    );

    return response.categoryItems;
  }
}
