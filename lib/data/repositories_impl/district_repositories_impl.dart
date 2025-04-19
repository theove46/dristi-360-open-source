import 'package:dristi_open_source/data/data_sources/districts_data_source.dart';
import 'package:dristi_open_source/domain/entities/district_entity.dart';
import 'package:dristi_open_source/domain/repositories/district_repositories.dart';

class DistrictRepositoryImp implements DistrictRepository {
  const DistrictRepositoryImp({required this.dataSource});

  final DistrictDataSource dataSource;

  @override
  Future<(String, List<DistrictEntity>?)> getDistrictComponents(
    String appLanguage,
  ) async {
    final response = await dataSource.getDistrictComponents(appLanguage);

    return Future.value((
      response.statusMessage!,
      response.data as List<DistrictEntity>?,
    ));
  }
}
