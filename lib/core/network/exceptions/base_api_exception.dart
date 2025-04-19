import 'package:dristi_open_source/core/network/exceptions/app_exception.dart';

abstract class BaseApiException extends AppException {
  final int httpCode;
  final String status;

  BaseApiException({this.httpCode = -1, this.status = "", super.message});
}
