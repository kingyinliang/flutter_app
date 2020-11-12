import 'package:flutter/material.dart';
import './routers.dart';
import 'package:dfmdsapp/utils/storage.dart';

// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = RoutersManager.instance.allRouters[name];
  if (settings.name == '/login') {
    print(true);
    SharedUtil.instance.saveBoolStorage('loginStatus', true);
  } else {
    print(false);
    SharedUtil.instance.saveBoolStorage('loginStatus', false);
  }
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else {
    return null;
  }
};

//继承NavigatorObserver
class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    // print('route.settings');
    // print(route.settings);
  }
}
