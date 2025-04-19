import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/constants/app_end_points.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/data/data_sources/on_boarding_data_source.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';
import 'package:dristi_open_source/data/response_models/minimum_version_response_model.dart';
import 'package:dristi_open_source/core/base/base_remote_source.dart';

class OnBoardingDataSourceImp extends BaseRemoteSource
    implements OnBoardingDataSource {
  final CacheService cacheService;

  OnBoardingDataSourceImp({required this.cacheService});

  @override
  Future<void> setFirstTimeStatusFalse() async {
    await cacheService.setFirstTimeOnBoardingFalse();
  }

  @override
  Future<bool> getFirstTimeStatus() async {
    return await cacheService.getFirstTimeOnBoardingStatus();
  }

  @override
  Future<Response> buttonSubmit() async {
    return Response(requestOptions: RequestOptions(), statusMessage: '');
  }

  @override
  Future<MinimumVersionResponseModel> fetchMinimumVersionRequired() async {
    // final String endpoint = DioProvider.baseUrl + API.minimumVersionVerify;

    try {
      //final Future<Response> dioCall = dioClient.get(endpoint);
      //final Response response = await callApiWithErrorParser(dioCall);
      //return MinimumVersionResponseModel.fromJson(json: response.data);

      final response = {"min_version": "1.0.4"};

      return MinimumVersionResponseModel.fromJson(json: response);
    } catch (e) {
      rethrow;
    }
  }
}
