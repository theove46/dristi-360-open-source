import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/categories_data_source.dart';
import 'package:dristi_open_source/data/response_models/categories_response_model.dart';
import 'package:flutter/services.dart';

class CategoriesDataSourceImp extends BaseRemoteSource
    implements CategoriesDataSource {
  final CacheService cacheService;

  CategoriesDataSourceImp({required this.cacheService});
  @override
  Future<CategoriesResponseModel> categoriesComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final cachedData = await cacheService.getCategoriesData();

    if (cachedData != null && cachedData.isNotEmpty && !isRefresh) {
      final List<dynamic> cachedList = jsonDecode(cachedData);
      return CategoriesResponseModel.fromJson(json: cachedList);
    }

    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.components}${API.language}$appLanguage${API.categories}';
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);
      // final Response response = await callApiWithErrorParser(dioCall);

      String endpoint =
          appLanguage == 'en' ? Assets.categoriesEn : Assets.categoriesEn;

      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);

      await cacheService.setCategoriesData(response);

      return CategoriesResponseModel.fromJson(json: jsonList);
    } catch (e) {
      rethrow;
    }
  }
}
