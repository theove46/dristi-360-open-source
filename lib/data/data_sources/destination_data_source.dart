import 'package:dio/dio.dart';
import 'package:dristi_open_source/data/data_sources_impl/destination_data_source_impl.dart';
import 'package:dristi_open_source/data/response_models/destination_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final destinationDataSourceProvider = Provider<DestinationDataSource>((ref) {
  return DestinationDataSourceImp();
});

abstract class DestinationDataSource {
  Future<DestinationResponseModel> getDestinationData(
    String appLanguage,
    String id,
  );

  Future<Response> getDestinationItems(String appLanguage);
}
