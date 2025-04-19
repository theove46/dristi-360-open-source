import 'package:dristi_open_source/data/data_sources/popular_districts_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/popular_districts_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/popular_districts_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularDistrictRepositoryProvider = Provider<PopularDistrictRepository>((
  ref,
) {
  final dataSource = ref.read(popularDistrictDataSourceProvider);
  return PopularDistrictRepositoryImp(dataSource: dataSource);
});

abstract class PopularDistrictRepository {
  Future<List<PopularDistrictEntity>> getPopularDistrictComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
