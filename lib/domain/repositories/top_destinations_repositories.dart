import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:dristi_open_source/data/data_sources/top_destinations_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/top_destinations_repositories_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topDestinationsRepositoryProvider = Provider<TopDestinationsRepository>((
  ref,
) {
  final dataSource = ref.read(topDestinationsDataSourceProvider);
  return TopDestinationsRepositoryImp(dataSource: dataSource);
});

abstract class TopDestinationsRepository {
  Future<List<DestinationsListEntity>> getTopDestinationsComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
