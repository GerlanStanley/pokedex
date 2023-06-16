import 'package:dio/dio.dart';

import '../../failures/failures.dart';
import '../../utils/utils.dart';

import 'http.dart';

class DioHttpHelperImpl implements HttpHelper {
  final Dio _dio;
  final Interceptor _interceptor;

  DioHttpHelperImpl(this._dio, this._interceptor) {
    _dio.interceptors.add(_interceptor);
  }

  @override
  Future<dynamic> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _dio.get(path, queryParameters: queryParameters);

      logRequest(response);

      return response.data;
    } on DioException catch (e) {
      validateCode(e);
    }
  }

  @override
  Future<dynamic> post<T>(
    String path, {
    dynamic data,
  }) async {
    try {
      var response = await _dio.post<T>(path, data: data);

      logRequest(response);

      return response.data;
    } on DioException catch (e) {
      validateCode(e);
    }
  }

  @override
  Future<dynamic> put<T>(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      var response = await _dio.put<T>(path, data: data);

      logRequest(response);

      return response.data;
    } on DioException catch (e) {
      validateCode(e);
    }
  }

  @override
  Future<dynamic> delete<T>(String path, {String? token}) async {
    try {
      var response = await _dio.delete<T>(path);

      logRequest(response);

      return response.data;
    } on DioException catch (e) {
      validateCode(e);
    }
  }

  dynamic validateCode(DioException error) {
    logRequest(error.response);

    if (error.response?.statusCode == 400) {
      throw BadRequestHttpFailure(message: "Bad Request");
    } else if (error.response?.statusCode == 401) {
      throw UnauthorizedHttpFailure(message: "Unauthorized");
    } else if (error.response?.statusCode == 404) {
      throw NotFoundHttpFailure(message: "Not Found");
    } else if (error.response?.statusCode == 500) {
      throw ServerHttpFailure(message: "Server Failure");
    } else {
      throw HttpFailure(message: "Request Error");
    }
  }

  void logRequest(Response? response) {
    printDebug(response?.realUri);
    printDebug(response?.requestOptions.data);
    printDebug(response?.statusCode);
    printDebug(response?.data);
  }
}
