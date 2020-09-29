import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'router/index.dart';
import 'package:dfmdsapp/config/config_init.dart';

class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

void main() async {
  // 初始化
  await ConfigInt.flutterDownloaderInit();
  await ConfigInt.sharedPreferencesInit();

  runApp(MyApp());

// 透明状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MaterialApp(
          home: new SplashScreen(),
          navigatorKey: Router.navigatorKey,
          navigatorObservers: [MyObserver()],
          debugShowCheckedModeBanner: false,
          // initialRoute: '/home',
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 2);
    _timer = new Timer(_duration, navigationPage);
    return _timer;
  }

  void navigationPage() {
    _timer.cancel();
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: new Image.asset(
          "lib/assets/images/appHome.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
