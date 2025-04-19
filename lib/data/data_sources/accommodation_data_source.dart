import 'package:dristi_open_source/data/data_sources_impl/accommodation_data_source_impl.dart';
import 'package:dristi_open_source/data/response_models/accommodation_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accommodationDataSourceProvider = Provider<AccommodationDataSource>((
  ref,
) {
  return AccommodationDataSourceImp();
});

abstract class AccommodationDataSource {
  Future<AccommodationResponseModel> getAccommodationData(
    String appLanguage,
    String id,
  );
}
