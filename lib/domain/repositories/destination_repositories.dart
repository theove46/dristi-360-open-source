import 'package:dristi_open_source/data/data_sources/destination_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/destination_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/destination_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final destinationRepositoryProvider = Provider<DestinationRepository>((ref) {
  final dataSource = ref.read(destinationDataSourceProvider);
  return DestinationRepositoryImp(dataSource: dataSource);
});

abstract class DestinationRepository {
  Future<DestinationEntity> getDestinationData(String appLanguage, String id);

  Future<(String, List<DestinationItemsEntity>?)> getDestinationItems(
    String appLanguage,
  );
}
