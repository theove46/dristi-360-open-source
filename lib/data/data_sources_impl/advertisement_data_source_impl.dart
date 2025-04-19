import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/advertisement_data_source.dart';
import 'package:dristi_open_source/data/response_models/advertisement_response_model.dart';
import 'package:flutter/services.dart';

class AdvertisementDataSourceImp extends BaseRemoteSource
    implements AdvertisementDataSource {
  final CacheService cacheService;

  AdvertisementDataSourceImp({required this.cacheService});
  @override
  Future<SingleAdvertisementResponseModel>
  getSingleAdvertisementComponents() async {
    final cachedData = await cacheService.getSingleAdvertisementData();

    if (cachedData != null && cachedData.isNotEmpty) {
      return SingleAdvertisementResponseModel.fromJson(
        json: jsonDecode(cachedData),
      );
    }

    try {
      // final String endpoint = DioProvider.baseUrl + API.singleAdvertisement;
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);
      // final Response response = await callApiWithErrorParser(dioCall);

      String endpoint = Assets.singleAdvertisement;
      String response = await rootBundle.loadString(endpoint);
      final dynamic jsonMap = json.decode(response);

      await cacheService.setSingleAdvertisementData(response);

      return SingleAdvertisementResponseModel.fromJson(json: jsonMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MultipleAdvertisementResponseModel>
  getMultipleAdvertisementComponents() async {
    final cachedData = await cacheService.getMultipleAdvertisementData();

    if (cachedData != null && cachedData.isNotEmpty) {
      final List<dynamic> cachedJson = jsonDecode(cachedData);
      return MultipleAdvertisementResponseModel.fromJson(json: cachedJson);
    }

    try {
      // final String endpoint = DioProvider.baseUrl + API.multipleAdvertisements;
      //
      // final Future<Response> dioCall = dioClient.get(endpoint);
      // final Response response = await callApiWithErrorParser(dioCall);

      String endpoint = Assets.multipleAdvertisement;
      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);

      await cacheService.setMultipleAdvertisementData(jsonEncode(jsonList));

      return MultipleAdvertisementResponseModel.fromJson(json: jsonList);
    } catch (e) {
      rethrow;
    }
  }
}
