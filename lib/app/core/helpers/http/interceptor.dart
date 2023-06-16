import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ApiConstants.apiUrlPrefix;
    return super.onRequest(options, handler);
  }
}
