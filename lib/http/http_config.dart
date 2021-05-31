import 'package:dio/dio.dart';

/// Http请求配置信息
class HttpConfig {
  /// base url
  String baseUrl;

  /// 拦截器集合
  List<Interceptor>? interceptors;

  HttpConfig({required this.baseUrl, this.interceptors});
}
