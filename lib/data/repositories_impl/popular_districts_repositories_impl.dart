import 'package:dristi_open_source/data/data_sources/popular_districts_data_source.dart';
import 'package:dristi_open_source/domain/entities/popular_districts_entity.dart';
import 'package:dristi_open_source/domain/repositories/popular_districts_repositories.dart';

class PopularDistrictRepositoryImp implements PopularDistrictRepository {
  const PopularDistrictRepositoryImp({required this.dataSource});

  final PopularDistrictDataSource dataSource;

  @override
  Future<List<PopularDistrictEntity>> getPopularDistrictComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final response = await dataSource.popularDistrictComponents(
      appLanguage: appLanguage,
      isRefresh: isRefresh,
    );

    return response.popularDistrictItems;
  }
}
