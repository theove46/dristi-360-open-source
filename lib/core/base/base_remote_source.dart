import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/network/dio_provider.dart';
import 'package:dristi_open_source/core/network/error_handlers.dart';
import 'package:dristi_open_source/core/network/exceptions/base_exception.dart';
import 'package:logger/logger.dart';

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.dioWithHeaderToken;

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: AppValues.loggerMethodCount,
      errorMethodCount: AppValues.loggerErrorMethodCount,
      lineLength: AppValues.loggerLineLength,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;

      return response;
    } on DioException catch (dioException) {
      Exception exception = handleDioError(dioException);
      logger.e(
        "Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}",
      );
      throw exception;
    } catch (error) {
      logger.e("Generic error: >>>>>>> $error");

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
