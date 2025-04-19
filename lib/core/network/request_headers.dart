import 'package:dio/dio.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((Map<String, String> customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    Map<String, String> customHeaders = <String, String>{
      'content-type': 'application/json'
    };

    return customHeaders;
  }
}
