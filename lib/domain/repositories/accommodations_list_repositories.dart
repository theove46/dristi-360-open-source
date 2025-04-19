import 'package:dristi_open_source/data/data_sources/accommodations_list_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/accommodations_list_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/accommodations_list_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accommodationsListRepositoryProvider =
    Provider<AccommodationsListRepository>((ref) {
      final dataSource = ref.read(accommodationsListDataSourceProvider);
      return AccommodationsListRepositoryImp(dataSource: dataSource);
    });

abstract class AccommodationsListRepository {
  Future<List<AccommodationsListEntity>> getAccommodationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
