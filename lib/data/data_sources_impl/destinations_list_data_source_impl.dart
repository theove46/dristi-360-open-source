import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/destinations_list_data_source.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/response_models/destinations_list_response_model.dart';
import 'package:flutter/services.dart';

class DestinationsListDataSourceImp extends BaseRemoteSource
    implements DestinationsListDataSource {
  final CacheService cacheService;

  DestinationsListDataSourceImp({required this.cacheService});

  @override
  Future<DestinationsListResponseModel> getDestinationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final cachedData = await cacheService.getDestinationsListData();
    final cachedTime = await cacheService.getDestinationsListDataTime();

    final bool isExpired =
        cachedTime == null || DateTime.now().difference(cachedTime).inDays > 1;

    if (cachedData != null &&
        cachedData.isNotEmpty &&
        !isRefresh &&
        !isExpired) {
      return DestinationsListResponseModel.fromJson(
        json: jsonDecode(cachedData),
      );
    }

    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.components}${API.language}$appLanguage${API.destinationsList}';

      // final Future<Response> dioCall = dioClient.get(endpoint);
      // final Response response = await callApiWithErrorParser(dioCall);

      String endpoint =
          appLanguage == 'en' ? Assets.destinationsEn : Assets.destinationsBn;

      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);

      await cacheService.setDestinationsListData(jsonEncode(jsonList));

      return DestinationsListResponseModel.fromJson(json: jsonList);
    } catch (e) {
      rethrow;
    }
  }
}
