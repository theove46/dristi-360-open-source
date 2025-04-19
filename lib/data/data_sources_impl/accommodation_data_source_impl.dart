import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/accommodation_data_source.dart';
import 'package:dristi_open_source/data/response_models/accommodation_response_model.dart';
import 'package:flutter/services.dart';

class AccommodationDataSourceImp extends BaseRemoteSource
    implements AccommodationDataSource {
  @override
  Future<AccommodationResponseModel> getAccommodationData(
    String appLanguage,
    String id,
  ) async {
    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.accommodations}${API.language}$appLanguage${'/$id.json'}';
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);

      String endpoint =
          appLanguage == 'en'
              ? Assets.sampleAccommodationEn
              : Assets.sampleAccommodationBn;

      final String response = await rootBundle.loadString(endpoint);

      final Map<String, dynamic> jsonMap = json.decode(response);

      return AccommodationResponseModel.fromJson(json: jsonMap);
    } catch (e) {
      rethrow;
    }
  }
}
