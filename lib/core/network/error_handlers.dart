import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/network/exceptions/api_exception.dart';
import 'package:dristi_open_source/core/network/exceptions/app_exception.dart';
import 'package:dristi_open_source/core/network/exceptions/network_exception.dart';
import 'package:dristi_open_source/core/network/exceptions/not_found_exception.dart';
import 'package:dristi_open_source/core/network/exceptions/service_unavailable_exception.dart';
import 'package:logger/logger.dart';

Exception handleError(String error) {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: AppValues.loggerMethodCount,
      errorMethodCount: AppValues.loggerErrorMethodCount,
      lineLength: AppValues.loggerLineLength,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  logger.e("Generic exception: $error");

  return AppException(message: error);
}

Exception handleDioError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.cancel:
      return AppException(message: "Request to API server was cancelled");
    case DioExceptionType.connectionTimeout:
      return AppException(message: "Connection timeout with API server");
    case DioExceptionType.connectionError:
      return NetworkException("There is no internet connection");
    case DioExceptionType.receiveTimeout:
      return TimeoutException("Receive timeout in connection with API server");
    case DioExceptionType.sendTimeout:
      return TimeoutException("Send timeout in connection with API server");
    case DioExceptionType.badResponse:
      return _parseDioErrorResponse(dioError);
    case DioExceptionType.badCertificate:
      return AppException(message: 'Bad certificate');
    case DioExceptionType.unknown:
      return NetworkException("There is no internet connection");
  }
}

Exception _parseDioErrorResponse(DioException dioError) {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: AppValues.loggerMethodCount,
      errorMethodCount: AppValues.loggerErrorMethodCount,
      lineLength: AppValues.loggerLineLength,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  int statusCode = dioError.response?.statusCode ?? -1;
  String? status;
  String? serverMessage;

  try {
    if (statusCode == -1 || statusCode == HttpStatus.ok) {
      statusCode = dioError.response?.data["statusCode"];
    }
    status = dioError.response?.data["status"];
    serverMessage = dioError.response?.data["message"];
  } catch (e, s) {
    logger.i("$e");
    logger.i(s.toString());

    serverMessage = "Something went wrong. Please try again later.";
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException("Service Temporarily Unavailable");
    case HttpStatus.notFound:
      return NotFoundException(serverMessage ?? "", status ?? "");
    default:
      return ApiException(
        httpCode: statusCode,
        status: status ?? "",
        message: serverMessage ?? "",
      );
  }
}
