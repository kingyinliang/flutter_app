import 'package:dfmdsapp/pages/wheat/list.dart';
import 'package:dfmdsapp/pages/wheat/add.dart';

Map<String, Function> wheatRouters = {
  '/wheat/list': (contxt, {arguments}) => WheatListPage(arguments: arguments),
  '/wheat/add': (contxt, {arguments}) => WheatAddPage(arguments: arguments),
};
