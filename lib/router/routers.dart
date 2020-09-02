import '../pages/login/login.dart';
import '../pages/index/index.dart';
import '../pages/sterilize/craft/list.dart';
import '../pages/sterilize/craft/materialList.dart';
import '../pages/sterilize/acceAdd/list.dart';
import '../pages/sterilize/acceAdd/home.dart';
import '../pages/sterilize/acceAdd/potAdd.dart';
import '../pages/sterilize/acceAdd/acceReceive.dart';
import '../pages/sterilize/acceAdd/materialAdd.dart';
import '../pages/sterilize/semiReceive/home.dart';
import '../pages/sterilize/semiReceive/add.dart';

Map<String, Function> routers = {
  '/': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(),
  '/sterilize/craftList': (contxt, {arguments}) => ListPage(),
  '/sterilize/materialList': (contxt, {arguments}) => MaterialList(),
  '/sterilize/acceAddList': (contxt, {arguments}) => AcceAddListPage(),
  '/sterilize/acceAdd/home': (contxt, {arguments}) => AcceAddHomePage(),
  '/sterilize/acceAdd/potAdd': (contxt, {arguments}) => PotAddPage(),
  '/sterilize/acceAdd/acceReceive': (contxt, {arguments}) => AcceReceivePage(),
  '/sterilize/acceAdd/materialAdd': (contxt, {arguments}) => MaterialAddPage(),
  '/sterilize/semiReceive/home': (contxt, {arguments}) => SemiReceivePage(),
  '/sterilize/semiReceive/add': (contxt, {arguments}) => AddSemiReceivePage(),
};
