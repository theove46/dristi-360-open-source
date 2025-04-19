import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/popular_districts_data_source.dart';
import 'package:dristi_open_source/data/response_models/popular_districts_response_model.dart';
import 'package:flutter/services.dart';

class PopularDistrictDataSourceImp extends BaseRemoteSource
    implements PopularDistrictDataSource {
  final CacheService cacheService;

  PopularDistrictDataSourceImp({required this.cacheService});
  @override
  Future<PopularDistrictsResponseModel> popularDistrictComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final cachedData = await cacheService.getPopularDistrictsData();

    if (cachedData != null && cachedData.isNotEmpty && !isRefresh) {
      final List<dynamic> cachedList = jsonDecode(cachedData);
      return PopularDistrictsResponseModel.fromJson(json: cachedList);
    }

    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.components}${API.language}$appLanguage${API.popularDistricts}';
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);
      // final Response response = await callApiWithErrorParser(dioCall);

      String endpoint =
          appLanguage == 'en'
              ? Assets.popularDistrictsEn
              : Assets.popularDistrictsBn;

      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);

      await cacheService.setPopularDistrictsData(response);

      return PopularDistrictsResponseModel.fromJson(json: jsonList);
    } catch (e) {
      rethrow;
    }
  }
}
