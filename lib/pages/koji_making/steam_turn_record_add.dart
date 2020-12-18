import 'package:dfmdsapp/utils/index.dart';
import 'package:date_format/date_format.dart';

class SteamTurnRecordAddPage extends StatefulWidget {
  final arguments;
  SteamTurnRecordAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamTurnRecordAddPageState createState() => _SteamTurnRecordAddPageState();
}

class _SteamTurnRecordAddPageState extends State<SteamTurnRecordAddPage> {
  Map<String, dynamic> formMap = {
    'orderNo': '',
    'kojiOrderNo': '',
    'exceptionInfo': '',
    'kojiDiscTurn1': {
      'kojiOrderNo': '',
      'orderNo': '',
      // 'status': '',
      'turnAddWaterAmount': '',
      'turnDuration': 0,
      'turnDurationString': '0 H',
      'turnEnd': '',
      'turnMans': '',
      'turnStage': 'ONE',
      'turnStageName': '一翻',
      'turnStart': '',
      'remark': '',
    },
    'kojiDiscTurn2': {
      'kojiOrderNo': '',
      'orderNo': '',
      // 'status': '',
      'turnAddWaterAmount': '',
      'turnDuration': 0,
      'turnDurationString': '0 H',
      'turnEnd': '',
      'turnMans': '',
      'turnStage': 'TWO',
      'turnStageName': '二翻',
      'turnStart': '',
      'remark': '',
    }
  };

  DateTime minGuardTime; // 最早看取记录时间

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    formMap['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    formMap['kojiDiscTurn1']['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiDiscTurn1']['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    formMap['kojiDiscTurn2']['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiDiscTurn2']['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    if (formMap['kojiDiscTurn1']['turnStart'] == null) {
      formMap['kojiDiscTurn1']['turnStart'] = '';
    }
    if (formMap['kojiDiscTurn1']['turnEnd'] == null) {
      formMap['kojiDiscTurn1']['turnEnd'] = '';
    }
    if (formMap['kojiDiscTurn2']['turnStart'] == null) {
      formMap['kojiDiscTurn2']['turnStart'] = '';
    }
    if (formMap['kojiDiscTurn2']['turnEnd'] == null) {
      formMap['kojiDiscTurn2']['turnEnd'] = '';
    }

    formMap['kojiDiscTurn1']['turnDurationString'] =
        '${formMap['kojiDiscTurn1']['turnDuration']} H';
    formMap['kojiDiscTurn2']['turnDurationString'] =
        '${formMap['kojiDiscTurn2']['turnDuration']} H';

    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
        _getKojiGuardData();
      }),
    );
    super.initState();
  }

  _initState() async {
    Map userData = await SharedUtil.instance.getMapStorage('userData');

    formMap['changed'] = formatDate(new DateTime.now(),
        ['yyyy', '-', 'mm', '-', 'dd', ' ', 'HH', ':', 'nn']);
    formMap['changer'] = userData['realName'];
  }

  // 获取时长
  _getDuration(String turn) async {
    await _getKojiGuardData();
    if (formMap[turn]['turnStart'] != '' && minGuardTime != null) {
      print('minGuardTime:' + minGuardTime.toString());
      int nowyear =
          int.parse(formMap[turn]['turnStart'].split(" ")[0].split('-')[0]);
      int nowmonth =
          int.parse(formMap[turn]['turnStart'].split(" ")[0].split('-')[1]);
      int nowday =
          int.parse(formMap[turn]['turnStart'].split(" ")[0].split('-')[2]);
      int nowhour =
          int.parse(formMap[turn]['turnStart'].split(" ")[1].split(':')[0]);
      int nowmin =
          int.parse(formMap[turn]['turnStart'].split(" ")[1].split(':')[1]);

      var now = new DateTime(nowyear, nowmonth, nowday, nowhour, nowmin);
      var difference = now.difference(minGuardTime);

      formMap[turn]['turnDuration'] =
          formatNum((difference.inMinutes / 60), 2); // 时间差
      formMap[turn]['turnDurationString'] =
          '${formMap[turn]['turnDuration']} H'; // 时间差

    }
  }

  formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    }
  }

  // 取看曲记录里最早时间
  _getKojiGuardData() async {
    try {
      var res = await KojiMaking.kojiQueryDiscGuard(
          {'kojiOrderNo': formMap['kojiOrderNo']});

      if (res['data'].length != 0) {
        minGuardTime = DateTime.parse(res['data'][0]['guardDate']);
        print(minGuardTime.toString());
        res['data'].forEach((item) {
          var d = DateTime.parse(item['guardDate']);
          print(d.toString());
          if (d.isBefore(minGuardTime)) {
            minGuardTime = d;
          }
        });
      }

      if (formMap['kojiDiscTurn1']['turnStart'] != '') {
        _getDuration('kojiDiscTurn1');
      }
      if (formMap['kojiDiscTurn1']['turnStart'] != '') {
        _getDuration('kojiDiscTurn2');
      }

      setState(() {});
    } catch (e) {}
  }

  _submitForm() async {
    if (formMap['kojiDiscTurn1']['turnStart'] == null ||
        formMap['kojiDiscTurn1']['turnStart'] == '') {
      errorToast(msg: '请选择一翻翻曲开始时间');
      return;
    }
    if (formMap['kojiDiscTurn1']['turnEnd'] == null ||
        formMap['kojiDiscTurn1']['turnEnd'] == '') {
      errorToast(msg: '请选择一翻翻曲结束时间');
      return;
    }
    if (formMap['kojiDiscTurn1']['turnMans'] == null ||
        formMap['kojiDiscTurn1']['turnMans'] == '') {
      errorToast(msg: '请选择一翻翻曲人');
      return;
    }
    if (formMap['kojiDiscTurn2']['turnStart'] == null ||
        formMap['kojiDiscTurn2']['turnStart'] == '') {
      errorToast(msg: '请选择二翻翻曲开始时间');
      return;
    }
    if (formMap['kojiDiscTurn2']['turnEnd'] == null ||
        formMap['kojiDiscTurn2']['turnEnd'] == '') {
      errorToast(msg: '请选择二翻翻曲结束时间');
      return;
    }
    if (formMap['kojiDiscTurn2']['turnMans'] == null ||
        formMap['kojiDiscTurn2']['turnMans'] == '') {
      errorToast(msg: '请选择二翻翻曲人');
      return;
    }

    if (formMap['kojiDiscTurn1']['id'] != null) {
      try {
        await KojiMaking.steamDiscTurnSave(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await KojiMaking.steamDiscTurnSave(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          FormTextWidget(
            label: '翻曲',
            // requiredFlg: true,
            prop: '一翻',
          ),
          DataPickerWidget(
            label: '翻曲开始时间',
            prop: formMap['kojiDiscTurn1']['turnStart'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['kojiDiscTurn1']['turnStart'] = val;
              this._getDuration('kojiDiscTurn1');
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '翻曲结束时间',
            prop: formMap['kojiDiscTurn1']['turnEnd'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['kojiDiscTurn1']['turnEnd'] = val;
              this._getDuration('kojiDiscTurn1');
              setState(() {});
            },
          ),
          FormTextWidget(
            label: '制曲时长',
            // requiredFlg: true,
            prop: (formMap['kojiDiscTurn1']['turnDurationString']).toString(),
          ),
          InputWidget(
            label: '翻曲加水量',
            keyboardType: 'number',
            prop: formMap['kojiDiscTurn1']['turnAddWaterAmount'].toString(),
            onChange: (val) {
              formMap['kojiDiscTurn1']['turnAddWaterAmount'] = val;
              setState(() {});
            },
          ),
          OrgSelectUser(
            label: '翻曲人',
            prop: formMap['kojiDiscTurn1']['turnMans'].split(','),
            requiredFlg: true,
            onChange: (List val) {
              formMap['kojiDiscTurn1']['turnMans'] = val.join(',');
              setState(() {});
            },
          ),
          InputWidget(
            label: '备注',
            prop: formMap['kojiDiscTurn1']['remark'].toString(),
            onChange: (val) {
              formMap['kojiDiscTurn1']['remark'] = val;
              setState(() {});
            },
          ),
          Container(
            height: 10,
            color: Color(0xFFF5F5F5),
          ),
          FormTextWidget(
            label: '翻曲',
            // requiredFlg: true,
            prop: '二翻',
          ),
          DataPickerWidget(
            label: '翻曲开始时间',
            prop: formMap['kojiDiscTurn2']['turnStart'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['kojiDiscTurn2']['turnStart'] = val;
              this._getDuration('kojiDiscTurn2');
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '翻曲结束时间',
            prop: formMap['kojiDiscTurn2']['turnEnd'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['kojiDiscTurn2']['turnEnd'] = val;
              this._getDuration('kojiDiscTurn2');
              setState(() {});
            },
          ),
          FormTextWidget(
            label: '制曲时长',
            // requiredFlg: true,
            prop: formMap['kojiDiscTurn2']['turnDurationString'].toString(),
          ),
          InputWidget(
            label: '翻曲加水量',
            keyboardType: 'number',
            prop: formMap['kojiDiscTurn2']['turnAddWaterAmount'].toString(),
            onChange: (val) {
              formMap['kojiDiscTurn2']['turnAddWaterAmount'] = val;
              setState(() {});
            },
          ),
          OrgSelectUser(
            label: '翻曲人',
            prop: formMap['kojiDiscTurn2']['turnMans'].split(','),
            requiredFlg: true,
            onChange: (List val) {
              formMap['kojiDiscTurn2']['turnMans'] = val.join(',');
              setState(() {});
            },
          ),
          InputWidget(
            label: '备注',
            keyboardType: 'text',
            prop: formMap['kojiDiscTurn2']['remark'].toString(),
            onChange: (val) {
              formMap['kojiDiscTurn2']['remark'] = val;
              setState(() {});
            },
          ),
          Container(
            height: 10,
            color: Color(0xFFF5F5F5),
          ),
          InputWidget(
            label: '异常情况',
            keyboardType: 'text',
            prop: formMap['exceptionInfo'].toString(),
            onChange: (val) {
              formMap['exceptionInfo'] = val;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(
          titleData: formMap['kojiDiscTurn1']['id'] == null ? '新增' : '修改'),
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
