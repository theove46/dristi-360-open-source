import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/accommodations_list_data_source.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/response_models/accommodations_list_response_model.dart';
import 'package:flutter/services.dart';

class AccommodationsListDataSourceImp extends BaseRemoteSource
    implements AccommodationsListDataSource {
  final CacheService cacheService;

  AccommodationsListDataSourceImp({required this.cacheService});
  @override
  Future<AccommodationsListResponseModel> getAccommodationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final cachedData = await cacheService.getAccommodationsListData();
    final cachedTime = await cacheService.getAccommodationsListDataTime();

    final bool isExpired =
        cachedTime == null || DateTime.now().difference(cachedTime).inDays > 1;

    if (cachedData != null &&
        cachedData.isNotEmpty &&
        !isRefresh &&
        !isExpired) {
      return AccommodationsListResponseModel.fromJson(
        json: jsonDecode(cachedData),
      );
    }

    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.components}${API.language}$appLanguage${API.accommodationsList}';
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);
      // return callApiWithErrorParser(dioCall).then((Response response) {
      //   return AccommodationsListResponseModel.fromJson(json: response.data);
      // });

      String endpoint =
          appLanguage == 'en'
              ? Assets.accommodationsEn
              : Assets.accommodationsBn;

      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);

      return AccommodationsListResponseModel.fromJson(json: jsonList);
    } catch (e) {
      rethrow;
    }
  }
}
