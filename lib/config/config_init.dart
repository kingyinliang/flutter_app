import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigInt {
  static SharedPreferences sp;

  static flutterDownloaderInit() async {
    await FlutterDownloader.initialize();
  }

  static sharedPreferencesInit() async {
    sp = await SharedPreferences.getInstance();
  }
}
