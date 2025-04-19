import 'package:dristi_open_source/data/data_sources/districts_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/district_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/district_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final districtRepositoryProvider = Provider<DistrictRepository>(
  (ref) {
    final dataSource = ref.read(districtDataSourceProvider);
    return DistrictRepositoryImp(dataSource: dataSource);
  },
);

abstract class DistrictRepository {
  Future<(String, List<DistrictEntity>?)> getDistrictComponents(
      String appLanguage);
}
