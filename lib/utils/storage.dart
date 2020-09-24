import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
    return jsonDecode(ConfigInt.sp.get(key));
  }

  Future getStorage(key) async {
    return ConfigInt.sp.get(key);
  }

  Future clear() async {
    return ConfigInt.sp.clear();
  }
}

Future saveStringStorage(key, value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, value);
}

Future saveIntStorage(key, value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt(key, value);
}

Future saveBoolStorage(key, value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(key, value);
}

Future saveDoubleStorage(key, value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setDouble(key, value);
}

Future saveStringListStorage(key, value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setStringList(key, value);
}

Future saveMapStorage(key, value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, jsonEncode(value).toString());
}

Future getMapStorage(key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return jsonDecode(sharedPreferences.get(key));
}

Future getStorage(key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.get(key);
}

Future clear() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.clear();
}
