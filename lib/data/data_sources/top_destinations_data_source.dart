import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/response_models/destinations_list_response_model.dart';
import 'package:dristi_open_source/data/data_sources_impl/top_destinations_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topDestinationsDataSourceProvider = Provider<TopDestinationsDataSource>((
  ref,
) {
  final cacheService = ref.read(cacheServiceProvider);
  return TopDestinationsDataSourceImp(cacheService: cacheService);
});

abstract class TopDestinationsDataSource {
  Future<DestinationsListResponseModel> getTopDestinationsComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
