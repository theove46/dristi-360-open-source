import 'package:dristi_open_source/data/data_sources/destinations_list_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/destinations_list_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final destinationsListRepositoryProvider = Provider<DestinationsListRepository>(
  (ref) {
    final dataSource = ref.read(destinationsListDataSourceProvider);
    return DestinationsListRepositoryImp(dataSource: dataSource);
  },
);

abstract class DestinationsListRepository {
  Future<List<DestinationsListEntity>> getDestinationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
