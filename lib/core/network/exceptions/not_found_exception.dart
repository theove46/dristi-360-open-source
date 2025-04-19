import 'dart:io';

import 'package:dristi_open_source/core/network/exceptions/api_exception.dart';

class NotFoundException extends ApiException {
  NotFoundException(String message, String status)
    : super(httpCode: HttpStatus.notFound, status: status, message: message);
}
