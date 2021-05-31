import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储，用于存放一些配置参数
class LocalStorage {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> save(String key, Object value) async {
    SharedPreferences prefs = await _prefs;
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    }
  }

  void get(String key) {}

  Future<bool> remove(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await _prefs;
    return prefs.clear();
  }
}
