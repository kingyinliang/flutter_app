import 'package:dfmdsapp/pages/koji_making/list.dart';
import 'package:dfmdsapp/pages/koji_making/steam_side.dart';
import 'package:dfmdsapp/pages/koji_making/steam_side_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_hardness.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_hardness_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_record.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_record_add.dart';

Map<String, Function> kojiMakingRouters = {
  '/kojiMaking/List': (contxt, {arguments}) =>
      KojiMakingListPage(arguments: arguments),
  '/kojiMaking/steamSide': (contxt, {arguments}) =>
      SteamSidePage(arguments: arguments),
  '/kojiMaking/steamSideAdd': (contxt, {arguments}) =>
      SteamSideAddPage(arguments: arguments),
  '/kojiMaking/steamBeanHardness': (contxt, {arguments}) =>
      SteamBeanHardnessPage(arguments: arguments),
  '/kojiMaking/steamBeanHardnessAdd': (contxt, {arguments}) =>
      SteamBeanHardnessAddPage(arguments: arguments),
  '/kojiMaking/steamBeanRecord': (contxt, {arguments}) =>
      SteamBeanRecordPage(arguments: arguments),
  '/kojiMaking/steamBeanRecordAdd': (contxt, {arguments}) =>
      SteamBeanRecordAddPage(arguments: arguments),
};
