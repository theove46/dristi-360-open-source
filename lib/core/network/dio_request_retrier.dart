import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';

class DioRequestRetrier {
  final Dio dioClient = DioProvider.tokenClient;
  final RequestOptions requestOptions;

  DioRequestRetrier({required this.requestOptions});

  Future<Response<T>> retry<T>() async {
    Map<String, String> header = await getCustomHeaders();

    return await dioClient.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      options: Options(headers: header, method: requestOptions.method),
    );
  }

  Future<Map<String, String>> getCustomHeaders() async {
    const String accessToken = "abcdefghijklmnopqrstuvwxyz";
    // TODO: Replace with access

    Map<String, String> customHeaders = <String, String>{
      'content-type': 'application/json',
    };
    if (accessToken.trim().isNotEmpty) {
      customHeaders.addAll(<String, String>{
        'Authorization': "Bearer $accessToken",
      });
    }

    return customHeaders;
  }
}
