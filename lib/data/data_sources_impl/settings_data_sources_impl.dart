import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/settings_data_sources.dart';
import 'package:dristi_open_source/data/response_models/settings_response_model.dart';
import 'package:flutter/services.dart';

class SettingsDataSourceImp extends BaseRemoteSource
    implements SettingsDataSource {
  final CacheService cacheService;

  SettingsDataSourceImp({required this.cacheService});
  @override
  Future<SettingsResponseModel> getSettingsComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final cachedData = await cacheService.getSettingsData();

    if (cachedData != null && cachedData.isNotEmpty && !isRefresh) {
      return SettingsResponseModel.fromJson(json: jsonDecode(cachedData));
    }

    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.components}${API.language}$appLanguage${API.settings}';
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);
      // final Response response = await callApiWithErrorParser(dioCall);

      String endpoint =
          appLanguage == 'en' ? Assets.settingsEn : Assets.settingsBn;

      final String response = await rootBundle.loadString(endpoint);
      final Map<String, dynamic> jsonMap = json.decode(response);

      await cacheService.setSettingsData(response);

      return SettingsResponseModel.fromJson(json: jsonMap);
    } catch (e) {
      rethrow;
    }
  }
}
