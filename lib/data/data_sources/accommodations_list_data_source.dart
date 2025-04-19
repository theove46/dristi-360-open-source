import 'package:dristi_open_source/data/data_sources_impl/accommodations_list_data_source_impl.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/response_models/accommodations_list_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accommodationsListDataSourceProvider =
    Provider<AccommodationsListDataSource>((ref) {
      final cacheService = ref.read(cacheServiceProvider);

      return AccommodationsListDataSourceImp(cacheService: cacheService);
    });

abstract class AccommodationsListDataSource {
  Future<AccommodationsListResponseModel> getAccommodationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
