import 'package:flutter/material.dart';
import 'router/index.dart';

class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Router.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
