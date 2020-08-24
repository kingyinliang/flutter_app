import '../pages/login/login.dart';
import '../pages/index/index.dart';
import '../pages/sterilize/craft/list.dart';
import '../pages/sterilize/acceAdd/list.dart';

Map<String, Function> routers = {
  '/': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(),
  '/sterilizeCraftList': (contxt, {arguments}) => ListPage(),
  '/sterilize/acceAddList': (contxt, {arguments}) => AcceAddListPage(),
};
