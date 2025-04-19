import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/destination_data_source.dart';
import 'package:dristi_open_source/data/response_models/destination_response_model.dart';
import 'package:flutter/services.dart';

class DestinationDataSourceImp extends BaseRemoteSource
    implements DestinationDataSource {
  @override
  Future<DestinationResponseModel> getDestinationData(
    String appLanguage,
    String id,
  ) async {
    try {
      // final String endpoint =
      //     '${DioProvider.baseUrl}${API.destinations}${API.language}$appLanguage/$id.json';
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);

      String endpoint =
          appLanguage == 'en'
              ? Assets.sampleDestinationEn
              : Assets.sampleDestinationBn;

      final String response = await rootBundle.loadString(endpoint);

      final Map<String, dynamic> jsonMap = json.decode(response);

      return DestinationResponseModel.fromJson(json: jsonMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getDestinationItems(String appLanguage) async {
    try {
      String endpoint =
          appLanguage == 'en'
              ? Assets.destinationComponentsEn
              : Assets.destinationComponentsBn;

      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);
      DestinationItemsResponseModel destinationResponse =
          DestinationItemsResponseModel.fromJson(jsonList);

      return Response(
        requestOptions: RequestOptions(),
        statusMessage: '',
        data: destinationResponse.data,
      );
    } catch (error) {
      return Response(
        requestOptions: RequestOptions(),
        statusMessage: 'Error loading data: $error',
        data: null,
      );
    }
  }
}
