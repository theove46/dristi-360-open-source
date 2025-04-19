import 'package:dio/dio.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/data_sources_impl/on_boarding_data_source_impl.dart';
import 'package:dristi_open_source/data/response_models/minimum_version_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onBoardingDataSourceProvider = Provider<OnBoardingDataSource>((ref) {
  final cacheService = ref.read(cacheServiceProvider);
  return OnBoardingDataSourceImp(cacheService: cacheService);
});

abstract class OnBoardingDataSource {
  Future<void> setFirstTimeStatusFalse();

  Future<bool> getFirstTimeStatus();

  Future<Response> buttonSubmit();

  Future<MinimumVersionResponseModel> fetchMinimumVersionRequired();
}
