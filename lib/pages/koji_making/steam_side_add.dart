import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/utils/storage.dart';

class SteamSideAddPage extends StatefulWidget {
  final arguments;
  SteamSideAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamSideAddPageState createState() => _SteamSideAddPageState();
}

class _SteamSideAddPageState extends State<SteamSideAddPage> {
  Map<String, dynamic> formMap = {
    'steamPacketPressure': '',
    'steamFlourSpeed': '',
    'steamFlourMans': '',
    'changed': '',
    'changer': '',
  };

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    } else {
      Future.delayed(
        Duration.zero,
        () => setState(() {
          _initState();
        }),
      );
    }
    formMap['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    super.initState();
  }

  _initState() async {
    Map userData = await SharedUtil.instance.getMapStorage('userData');

    formMap['changed'] = formatDate(new DateTime.now(),
        ['yyyy', '-', 'mm', '-', 'dd', ' ', 'HH', ':', 'nn']);
    formMap['changer'] = userData['realName'];
  }

  _submitForm() async {
    if (formMap['steamPacketPressure'] == null ||
        formMap['steamPacketPressure'] == '') {
      errorToast(msg: '请填写气泡压力');
      return;
    }
    if (formMap['steamFlourSpeed'] == null ||
        formMap['steamFlourSpeed'] == '') {
      errorToast(msg: '请填写蒸面加水加压');
      return;
    }
    if (formMap['steamFlourMans'] == null || formMap['steamFlourMans'] == '') {
      errorToast(msg: '请选择蒸面操作人');
      return;
    }
    if (formMap['id'] != null) {
      try {
        await KojiMaking.steamSideUpdate(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await KojiMaking.steamSideAdd(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(children: <Widget>[
        InputWidget(
          label: '气泡压力',
          suffix: 'Mpa',
          keyboardType: 'number',
          prop: formMap['steamPacketPressure'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['steamPacketPressure'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '蒸面加水加压',
          suffix: 'L/H',
          keyboardType: 'number',
          prop: formMap['steamFlourSpeed'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['steamFlourSpeed'] = val;
            setState(() {});
          },
        ),
        OrgSelectUser(
          label: '蒸面操作人',
          prop: formMap['steamFlourMans'].split(','),
          requiredFlg: true,
          onChange: (List val) {
            formMap['steamFlourMans'] = val.join(',');
            setState(() {});
          },
        ),
        FormTextWidget(
          label: '操作人',
          prop: formMap['changer'].toString(),
        ),
        FormTextWidget(
          label: '操作时间',
          prop: formMap['changed'].toString(),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: formMap['id'] == null ? '新增' : '修改'),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          formWidget(),
          SizedBox(height: 34),
          MdsWidthButton(
            text: '确定',
            onPressed: _submitForm,
          ),
          SizedBox(height: 34),
        ],
      ),
    );
  }
}
