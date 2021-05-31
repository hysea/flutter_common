import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

/// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

/// 官方建议json的解码通过compute方法在后台进行，这样可以避免在解析复杂json时导致的UI卡顿
parseJson(String text) {
  return compute(_parseAndDecode, text);
}

/// Base Http
abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    // json解析
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    init();
  }

  /// 初始化操作，如配置baseUrl，设置拦截器等
  void init();
}
