import 'package:flutter_common/http/http_config.dart';

/// 全局配置入口，采用单例模式
class Config {
  /// http配置参数
  late HttpConfig httpConfig;

  Config._();

  static final _instance = Config._();

  factory Config.getInstance() => _instance;
}
