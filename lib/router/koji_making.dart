import 'package:dfmdsapp/pages/koji_making/list.dart';
import 'package:dfmdsapp/pages/koji_making/exeption.dart';
import 'package:dfmdsapp/pages/koji_making/steam_side.dart';
import 'package:dfmdsapp/pages/koji_making/steam_side_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_hardness.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_hardness_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_record.dart';
import 'package:dfmdsapp/pages/koji_making/steam_bean_record_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_hybrid_control.dart';
import 'package:dfmdsapp/pages/koji_making/steam_hybrid_control_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_in_status.dart';
import 'package:dfmdsapp/pages/koji_making/steam_in_status_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_look_record.dart';
import 'package:dfmdsapp/pages/koji_making/steam_look_record_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_grow_evaluate.dart';
import 'package:dfmdsapp/pages/koji_making/steam_grow_evaluate_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_turn_record.dart';
import 'package:dfmdsapp/pages/koji_making/steam_turn_record_add.dart';
import 'package:dfmdsapp/pages/koji_making/steam_out_record.dart';
import 'package:dfmdsapp/pages/koji_making/steam_out_record_add.dart';

Map<String, Function> kojiMakingRouters = {
  '/kojiMaking/List': (contxt, {arguments}) =>
      KojiMakingListPage(arguments: arguments),
  '/kojiMaking/exeption': (contxt, {arguments}) =>
      ExeptionPage(arguments: arguments),
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
  '/kojiMaking/steamHybridControl': (contxt, {arguments}) =>
      SteamHybridControlPage(arguments: arguments),
  '/kojiMaking/steamHybridControlAdd': (contxt, {arguments}) =>
      SteamHybridControlAddPage(arguments: arguments),
  '/kojiMaking/steamInStatus': (contxt, {arguments}) =>
      SteamInStatusPage(arguments: arguments),
  '/kojiMaking/steamInStatusAdd': (contxt, {arguments}) =>
      SteamInStatusAddPage(arguments: arguments),
  '/kojiMaking/steamLookRecord': (contxt, {arguments}) =>
      SteamLookRecordPage(arguments: arguments),
  '/kojiMaking/steamLookRecordAdd': (contxt, {arguments}) =>
      SteamLookRecordAddPage(arguments: arguments),
  '/kojiMaking/steamGrowEvaluate': (contxt, {arguments}) =>
      SteamGrowEvaluatePage(arguments: arguments),
  '/kojiMaking/steamGrowEvaluateAdd': (contxt, {arguments}) =>
      SteamGrowEvaluateAddPage(arguments: arguments),
  '/kojiMaking/steamTurnRecord': (contxt, {arguments}) =>
      SteamTurnRecordPage(arguments: arguments),
  '/kojiMaking/steamTurnRecordAdd': (contxt, {arguments}) =>
      SteamTurnRecordAddPage(arguments: arguments),
  '/kojiMaking/steamOutRecord': (contxt, {arguments}) =>
      SteamOutRecordPage(arguments: arguments),
  '/kojiMaking/steamOutRecordAdd': (contxt, {arguments}) =>
      SteamOutRecordAddPage(arguments: arguments),
};
