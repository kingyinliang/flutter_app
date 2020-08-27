import '../pages/login/login.dart';
import '../pages/index/index.dart';
import '../pages/sterilize/craft/list.dart';
import '../pages/sterilize/craft/materialList.dart';
import '../pages/sterilize/acceAdd/list.dart';
import '../pages/sterilize/acceAdd/home.dart';
import '../pages/sterilize/acceAdd/potAdd.dart';
import '../pages/sterilize/acceAdd/acceReceive.dart';
import '../pages/sterilize/acceAdd/materialAdd.dart';

Map<String, Function> routers = {
  '/': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(),
  '/sterilize/craftList': (contxt, {arguments}) => ListPage(),
  '/sterilize/materialList': (contxt, {arguments}) => MaterialList(),
  '/sterilize/acceAddList': (contxt, {arguments}) => AcceAddListPage(),
  '/sterilize/acceAddHome': (contxt, {arguments}) => AcceAddHomePage(),
  '/sterilize/potAdd': (contxt, {arguments}) => PotAddPage(),
  '/sterilize/acceReceive': (contxt, {arguments}) => AcceReceivePage(),
  '/sterilize/materialAdd': (contxt, {arguments}) => MaterialAddPage(),
};
