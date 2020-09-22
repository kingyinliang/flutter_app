import '../pages/login/login.dart';
import '../pages/index/index.dart';
import '../pages/index/user/user_info.dart';
import '../pages/index/user/versions.dart';
import '../pages/index/user/update_pasword.dart';
import '../pages/sterilize/barcode.dart';
import '../pages/sterilize/craft/list.dart';
import '../pages/sterilize/craft/materialList.dart';
import '../pages/sterilize/craft/materialAdd.dart';
import '../pages/sterilize/craft/timeAdd.dart';
import '../pages/sterilize/exception/home.dart';
import '../pages/sterilize/exception/add.dart';
import '../pages/sterilize/list.dart';
import '../pages/sterilize/acceAdd/home.dart';
import '../pages/sterilize/acceAdd/potAdd.dart';
import '../pages/sterilize/acceAdd/acceReceive.dart';
import '../pages/sterilize/acceAdd/materialAdd.dart';
import '../pages/sterilize/semiReceive/home.dart';
import '../pages/sterilize/semiReceive/add.dart';

Map<String, Function> routers = {
  '/login': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(),
  '/user/userinfo': (contxt, {arguments}) => UserInfoPage(arguments: arguments),
  '/user/versions': (contxt, {arguments}) => VersionsPage(arguments: arguments),
  '/user/updatepasword': (contxt, {arguments}) =>
      UpdatePaswordPage(arguments: arguments),
  '/sterilize/barcode': (contxt, {arguments}) =>
      BarCodePage(arguments: arguments),
  '/sterilize/list': (contxt, {arguments}) =>
      AcceAddListPage(arguments: arguments),
  '/sterilize/craft/list': (contxt, {arguments}) => CraftListPage(arguments: arguments),
  '/sterilize/craft/materialList': (contxt, {arguments}) => CraftMaterialList(arguments: arguments),
   '/sterilize/craft/materialAdd': (contxt, {arguments}) => CraftMaterialAdd(arguments: arguments),
  '/sterilize/craft/timeAdd': (contxt, {arguments}) => CraftTimeAdd(arguments: arguments),
  '/sterilize/exception/home': (contxt, {arguments}) => CraftExceptionHome(arguments: arguments),
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
