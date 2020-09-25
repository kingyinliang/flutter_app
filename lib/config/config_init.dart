import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dfmdsapp/main.dart';
import 'package:dfmdsapp/utils/storage.dart';

class ConfigInt {
  static SharedPreferences sp;
  static var connect;

  static flutterDownloaderInit() async {
    await FlutterDownloader.initialize();
  }

  static sharedPreferencesInit() async {
    sp = await SharedPreferences.getInstance();
  }

  static connectivityInit() async {
    connect = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print(result);
      if (result != ConnectivityResult.mobile &&
          result != ConnectivityResult.wifi) {
        await SharedUtil.instance.saveBoolStorage('netStatus', false);
        Future.delayed(Duration.zero, () {
          Router.navigatorKey.currentState.pushNamed('/noNet');
        });
      } else {
        await SharedUtil.instance.saveBoolStorage('netStatus', true);
      }
    });
  }
}
