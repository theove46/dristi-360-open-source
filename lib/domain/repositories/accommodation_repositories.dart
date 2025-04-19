import 'package:dristi_open_source/data/repositories_impl/accommodation_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/accommodation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dristi_open_source/data/data_sources/accommodation_data_source.dart';

final accommodationRepositoryProvider = Provider<AccommodationRepository>((
  ref,
) {
  final dataSource = ref.read(accommodationDataSourceProvider);
  return AccommodationRepositoryImp(dataSource: dataSource);
});

abstract class AccommodationRepository {
  Future<AccommodationEntity> getAccommodationData(
    String appLanguage,
    String id,
  );
}
