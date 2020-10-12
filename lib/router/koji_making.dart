import 'package:dfmdsapp/pages/koji_making/list.dart';
import 'package:dfmdsapp/pages/koji_making/steam_side.dart';
import 'package:dfmdsapp/pages/koji_making/steam_side_add.dart';

Map<String, Function> kojiMakingRouters = {
  '/kojiMaking/List': (contxt, {arguments}) =>
      KojiMakingListPage(arguments: arguments),
  '/kojiMaking/steamSide': (contxt, {arguments}) =>
      SteamSidePage(arguments: arguments),
  '/kojiMaking/steamSideAdd': (contxt, {arguments}) =>
      SteamSideAddPage(arguments: arguments),
};
