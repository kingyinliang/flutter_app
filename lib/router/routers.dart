import '../pages/login/login.dart';
import '../pages/index/index.dart';
import '../pages/sterilize/barcode.dart';
import '../pages/sterilize/craft/list.dart';
import '../pages/sterilize/craft/materialList.dart';
// import '../pages/sterilize/craft/materialAdd.dart';
// import '../pages/sterilize/craft/timeAdd.dart';
import '../pages/sterilize/exception/add.dart';
import '../pages/sterilize/list.dart';
import '../pages/sterilize/acceAdd/home.dart';
import '../pages/sterilize/acceAdd/potAdd.dart';
import '../pages/sterilize/acceAdd/acceReceive.dart';
import '../pages/sterilize/acceAdd/materialAdd.dart';
import '../pages/sterilize/semiReceive/home.dart';
import '../pages/sterilize/semiReceive/add.dart';

Map<String, Function> routers = {
  '/': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(),
  '/sterilize/barcode': (contxt, {arguments}) =>
      BarCodePage(arguments: arguments),
  '/sterilize/list': (contxt, {arguments}) =>
      AcceAddListPage(arguments: arguments),
  '/sterilize/craft/list': (contxt, {arguments}) => ListPage(),
  '/sterilize/craft/materialList': (contxt, {arguments}) => MaterialList(),
  // '/sterilize/craft/materialAdd': (contxt, {arguments}) => MaterialAdd(),
  // '/sterilize/craft/timeAdd': (contxt, {arguments}) => TimeAdd(),
  '/sterilize/craft/exceptionAdd': (contxt, {arguments}) => ExceptionAdd(),
  '/sterilize/acceAdd/home': (contxt, {arguments}) =>
      AcceAddHomePage(arguments: arguments),
  '/sterilize/acceAdd/potAdd': (contxt, {arguments}) =>
      PotAddPage(arguments: arguments),
  '/sterilize/acceAdd/acceReceive': (contxt, {arguments}) =>
      AcceReceivePage(arguments: arguments),
  '/sterilize/acceAdd/materialAdd': (contxt, {arguments}) =>
      MaterialAddPage(arguments: arguments),
  '/sterilize/semiReceive/home': (contxt, {arguments}) =>
      SemiReceivePage(arguments: arguments),
  '/sterilize/semiReceive/add': (contxt, {arguments}) =>
      AddSemiReceivePage(arguments: arguments),
};
