import 'package:dristi_open_source/data/data_sources_impl/destinations_list_data_source_impl.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/response_models/destinations_list_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final destinationsListDataSourceProvider = Provider<DestinationsListDataSource>(
  (ref) {
    final cacheService = ref.read(cacheServiceProvider);

    return DestinationsListDataSourceImp(cacheService: cacheService);
  },
);

abstract class DestinationsListDataSource {
  Future<DestinationsListResponseModel> getDestinationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
