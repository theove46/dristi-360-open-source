import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/data_sources_impl/advertisement_data_source_impl.dart';
import 'package:dristi_open_source/data/response_models/advertisement_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advertisementDataSourceProvider = Provider<AdvertisementDataSource>((
  ref,
) {
  final cacheService = ref.read(cacheServiceProvider);

  return AdvertisementDataSourceImp(cacheService: cacheService);
});

abstract class AdvertisementDataSource {
  Future<SingleAdvertisementResponseModel> getSingleAdvertisementComponents();

  Future<MultipleAdvertisementResponseModel>
  getMultipleAdvertisementComponents();
}
