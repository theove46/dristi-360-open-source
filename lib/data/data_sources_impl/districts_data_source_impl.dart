import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/data/data_sources/districts_data_source.dart';
import 'package:dristi_open_source/data/response_models/district_response_model.dart';
import 'package:flutter/services.dart';

class DistrictDataSourceImp implements DistrictDataSource {
  const DistrictDataSourceImp();

  @override
  Future<Response> getDistrictComponents(String appLanguage) async {
    try {
      String endpoint =
          appLanguage == 'en'
              ? Assets.districtComponentsEn
              : Assets.districtComponentsBn;

      String response = await rootBundle.loadString(endpoint);
      final List<dynamic> jsonList = json.decode(response);
      DistrictResponseModel districtResponse = DistrictResponseModel.fromJson(
        jsonList,
      );

      return Response(
        requestOptions: RequestOptions(),
        statusMessage: '',
        data: districtResponse.data,
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
