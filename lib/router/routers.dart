import './sterilize.dart';
import './koji_making.dart';

import 'package:dfmdsapp/pages/common/no_net.dart';
import 'package:dfmdsapp/pages/login/login.dart';
import 'package:dfmdsapp/pages/index/index.dart';
import 'package:dfmdsapp/pages/index/user/user_info.dart';
import 'package:dfmdsapp/pages/index/user/versions.dart';
import 'package:dfmdsapp/pages/index/user/update_pasword.dart';

Map<String, Function> commonRouters = {
  '/noNet': (contxt, {arguments}) => NoNetPage(),
  '/login': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(arguments: arguments),
  '/list': (contxt, {arguments}) => IndexPage(arguments: arguments),
  '/user/userinfo': (contxt, {arguments}) => UserInfoPage(arguments: arguments),
  '/user/versions': (contxt, {arguments}) => VersionsPage(arguments: arguments),
  '/user/updatepasword': (contxt, {arguments}) =>
      UpdatePaswordPage(arguments: arguments),
};

class RoutersManager {
  Map<String, Function> allRouters = {};
  factory RoutersManager() => _getInstance();

  static RoutersManager get instance => _getInstance();
  static RoutersManager _instance;

  RoutersManager._internal() {
    print('router初始化');
    allRouters.addAll(commonRouters);
    allRouters.addAll(steilizeRouters);
    allRouters.addAll(kojiMakingRouters);
  }

  static RoutersManager _getInstance() {
    if (_instance == null) {
      _instance = new RoutersManager._internal();
    }
    return _instance;
  }
}
