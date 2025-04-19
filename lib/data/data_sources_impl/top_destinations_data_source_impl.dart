import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/response_models/destinations_list_response_model.dart';
import 'package:dristi_open_source/data/data_sources/top_destinations_data_source.dart';
import 'package:flutter/services.dart';

class TopDestinationsDataSourceImp extends BaseRemoteSource
    implements TopDestinationsDataSource {
  final CacheService cacheService;

  TopDestinationsDataSourceImp({required this.cacheService});
  @override
  Future<DestinationsListResponseModel> getTopDestinationsComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final cachedData = await cacheService.getTopDestinationsData();

    if (cachedData != null && cachedData.isNotEmpty && !isRefresh) {
      final List<dynamic> cachedList = jsonDecode(cachedData);
      return DestinationsListResponseModel.fromJson(json: cachedList);
    }

    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.components}${API.language}$appLanguage${API.topDestinations}';
      // final Future<Response> dioCall = dioClient.get(endpoint);
      // final Response response = await callApiWithErrorParser(dioCall);

      String endpoint =
          appLanguage == 'en'
              ? Assets.topDestinationsEn
              : Assets.topDestinationsBn;

      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);

      await cacheService.setTopDestinationsData(response);

      return DestinationsListResponseModel.fromJson(json: jsonList);
    } catch (e) {
      rethrow;
    }
  }
}
