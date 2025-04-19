import 'package:dristi_open_source/core/network/exceptions/base_api_exception.dart';

class ApiException extends BaseApiException {
  ApiException({required super.httpCode, required super.status, super.message});
}
