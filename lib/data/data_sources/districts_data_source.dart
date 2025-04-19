import 'package:dio/dio.dart';
import 'package:dristi_open_source/data/data_sources_impl/districts_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final districtDataSourceProvider = Provider<DistrictDataSource>((ref) {
  return const DistrictDataSourceImp();
});

abstract class DistrictDataSource {
  Future<Response> getDistrictComponents(String appLanguage);
}
