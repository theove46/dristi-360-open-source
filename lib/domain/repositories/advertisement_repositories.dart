import 'package:dristi_open_source/data/data_sources/advertisement_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/advertisement_repositories_impl.dart';
import 'package:dristi_open_source/domain/entities/advertisement_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advertisementRepositoryProvider = Provider<AdvertisementRepository>(
  (ref) {
    final dataSource = ref.read(advertisementDataSourceProvider);
    return AdvertisementRepositoryImp(dataSource: dataSource);
  },
);

abstract class AdvertisementRepository {
  Future<AdvertisementEntity> getSingleAdvertisementComponents();
  Future<List<AdvertisementEntity>> getMultipleAdvertisementComponents();
}
