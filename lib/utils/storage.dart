import 'dart:convert';
import 'package:dfmdsapp/config/config_init.dart';

class SharedUtil {
  factory SharedUtil() => _getInstance();

  static SharedUtil get instance => _getInstance();
  static SharedUtil _instance;

  SharedUtil._internal() {
    //初始化
    //init
  }

  static SharedUtil _getInstance() {
    if (_instance == null) {
      _instance = new SharedUtil._internal();
    }
    return _instance;
  }

  Future saveStringStorage(key, value) async {
    ConfigInt.sp.setString(key, value);
  }

  Future saveIntStorage(key, value) async {
    ConfigInt.sp.setInt(key, value);
  }

  Future saveBoolStorage(key, value) async {
    ConfigInt.sp.setBool(key, value);
  }

  Future saveDoubleStorage(key, value) async {
    ConfigInt.sp.setDouble(key, value);
  }

  Future saveStringListStorage(key, value) async {
    ConfigInt.sp.setStringList(key, value);
  }

  Future saveMapStorage(key, value) async {
    ConfigInt.sp.setString(key, jsonEncode(value).toString());
  }

  Future getMapStorage(key) async {
    if (ConfigInt.sp.get(key) == null) {
      return null;
    }
    return jsonDecode(ConfigInt.sp.get(key));
  }

  Future getStorage(key) async {
    return ConfigInt.sp.get(key);
  }

  Future clear() async {
    return ConfigInt.sp.clear();
  }
}
