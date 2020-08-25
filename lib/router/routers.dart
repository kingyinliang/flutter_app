import '../pages/login/login.dart';
import '../pages/index/index.dart';
import '../pages/sterilize/craft/list.dart';
import '../pages/sterilize/craft/materialList.dart';
import '../pages/sterilize/acceAdd/list.dart';
import '../pages/sterilize/acceAdd/home.dart';

Map<String, Function> routers = {
  '/': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(),
  '/sterilize/craftList': (contxt, {arguments}) => ListPage(),
  '/sterilize/materialList': (contxt, {arguments}) => MaterialList(),
  '/sterilize/acceAddList': (contxt, {arguments}) => AcceAddListPage(),
  '/sterilize/acceAddHome': (contxt, {arguments}) => AcceAddHomePage(),
};
