import './sterilize.dart';
import './koji_making.dart';
import './wheat.dart';

import 'package:dfmdsapp/pages/common/no_net.dart';
import 'package:dfmdsapp/pages/login/login.dart';
import 'package:dfmdsapp/pages/index/index.dart';
import 'package:dfmdsapp/pages/index/user/user_info.dart';
import 'package:dfmdsapp/pages/index/user/versions.dart';
import 'package:dfmdsapp/pages/index/user/update_pasword.dart';
import 'package:dfmdsapp/components/org_select_user_page.dart';
import 'package:dfmdsapp/components/search.dart';
import 'package:dfmdsapp/components/pagesComponents/text_add.dart';
import 'package:dfmdsapp/components/pagesComponents/exeption_add.dart';

import 'package:dfmdsapp/components/web_view.dart';

Map<String, Function> commonRouters = {
  '/noNet': (contxt, {arguments}) => NoNetPage(),
  '/webview': (contxt, {arguments}) => WebViewPage(arguments: arguments),
  '/login': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(arguments: arguments),
  '/list': (contxt, {arguments}) => IndexPage(arguments: arguments),
  '/search': (contxt, {arguments}) => SearchWidget(arguments: arguments),
  '/textAdd': (contxt, {arguments}) => TextAddPage(arguments: arguments),
  '/exeptionAdd': (contxt, {arguments}) =>
      ExeptionAddPage(arguments: arguments),
  '/orgSelectUser': (contxt, {arguments}) =>
      OrgSelectUserPage(arguments: arguments),
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
    allRouters.addAll(wheatRouters);
  }

  static RoutersManager _getInstance() {
    if (_instance == null) {
      _instance = new RoutersManager._internal();
    }
    return _instance;
  }
}
