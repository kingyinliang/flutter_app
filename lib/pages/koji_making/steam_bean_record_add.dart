import 'package:dfmdsapp/utils/index.dart';

class SteamBeanRecordAddPage extends StatefulWidget {
  final arguments;
  SteamBeanRecordAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamBeanRecordAddPageState createState() => _SteamBeanRecordAddPageState();
}

class _SteamBeanRecordAddPageState extends State<SteamBeanRecordAddPage> {
  Map<String, dynamic> formMap = {
    'steamBallPressure': '',
    'steamBallId': '',
    'steamBallNo': '',
    'steamBallName': '',
    'addSteamStart': '',
    'addSteamEnd': '',
    'steamPocketPressure': '',
    'turnCount': '',
    'cookingDuration': '',
    'cookingDurationString': '',
    'pressureDuration': '',
    'addBeanDate': '',
    'remark': '',
  };
  List steamBallNo = [];
  bool _steamBallPressureVisible = false;
  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    formMap['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];

    if (widget.arguments['kojiOrderNo'] == '') {
      _steamBallPressureVisible = true;
    }
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getSteamBallNo();
      }),
    );
    super.initState();
  }

  _getSteamBallNo() async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery({
        'deptId': workShop,
        'holderType': ['026']
      });
      steamBallNo = res['data'];
      setState(() {});
    } catch (e) {}
  }

  // 获取时长
  _getDuration() {
    if (formMap['addSteamStart'] != '' && formMap['addSteamEnd'] != '') {
      int nowyear =
          int.parse(formMap['addSteamStart'].split(" ")[0].split('-')[0]);
      int nowmonth =
          int.parse(formMap['addSteamStart'].split(" ")[0].split('-')[1]);
      int nowday =
          int.parse(formMap['addSteamStart'].split(" ")[0].split('-')[2]);
      int nowhour =
          int.parse(formMap['addSteamStart'].split(" ")[1].split(':')[0]);
      int nowmin =
          int.parse(formMap['addSteamStart'].split(" ")[1].split(':')[1]);

      int oldyear =
          int.parse(formMap['addSteamEnd'].split(" ")[0].split('-')[0]);
      int oldmonth =
          int.parse(formMap['addSteamEnd'].split(" ")[0].split('-')[1]);
      int oldday =
          int.parse(formMap['addSteamEnd'].split(" ")[0].split('-')[2]);
      int oldhour =
          int.parse(formMap['addSteamEnd'].split(" ")[1].split(':')[0]);
      int oldmin =
          int.parse(formMap['addSteamEnd'].split(" ")[1].split(':')[1]);

      var now = new DateTime(nowyear, nowmonth, nowday, nowhour, nowmin);
      var old = new DateTime(oldyear, oldmonth, oldday, oldhour, oldmin);
      var difference = old.difference(now);

      formMap['cookingDuration'] =
          formatNum((difference.inMinutes / 1), 2); // 时间差
      formMap['cookingDurationString'] =
          '${formMap['cookingDuration']} min'; // 时间差

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

  _submitForm() async {
    if (formMap['id'] != null) {
      try {
        await KojiMaking.steamBeanRecordUpdate(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await KojiMaking.steamBeanRecordAdd(formMap);
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
          _steamBallPressureVisible
              ? InputWidget(
                  label: '蒸球压力',
                  suffix: 'Mpa',
                  keyboardType: 'number',
                  prop: formMap['steamBallPressure'].toString(),
                  requiredFlg: true,
                  onChange: (val) {
                    formMap['steamBallPressure'] = val;
                    setState(() {});
                  })
              : Container(),
          SelectWidget(
            label: '蒸球号',
            prop: formMap['steamBallNo'].toString(),
            requiredFlg: true,
            options: steamBallNo,
            optionsLabel: 'holderName',
            optionsval: 'holderNo',
            onChange: (val) {
              formMap['steamBallId'] = val['id'];
              formMap['steamBallNo'] = val['holderNo'];
              formMap['steamBallName'] = val['holderName'];
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '加汽开始时间',
            prop: formMap['addSteamStart'],
            requiredFlg: true,
            onChange: (val) {
              formMap['addSteamStart'] = val;
              this._getDuration();
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '加汽结束时间',
            prop: formMap['addSteamEnd'],
            requiredFlg: true,
            onChange: (val) {
              formMap['addSteamEnd'] = val;
              this._getDuration();
              setState(() {});
            },
          ),
          InputWidget(
            label: '汽包压力',
            suffix: 'Mpa',
            keyboardType: 'number',
            prop: formMap['steamPocketPressure'].toString(),
            onChange: (val) {
              formMap['steamPocketPressure'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '转动圈数',
            keyboardType: 'number',
            prop: formMap['turnCount'].toString(),
            onChange: (val) {
              formMap['turnCount'] = val;
              setState(() {});
            },
          ),
          FormTextWidget(
            label: '蒸煮时间',
            prop: formMap['cookingDurationString'].toString(),
            // suffix: 'min',
            // keyboardType: 'number',
            // requiredFlg: true,
            // prop: formMap['cookingDuration'].toString(),
            // onChange: (val) {
            //   formMap['cookingDuration'] = val;
            //   setState(() {});
            // },
          ),
          InputWidget(
            label: '保压时间',
            suffix: 'min',
            keyboardType: 'number',
            prop: formMap['pressureDuration'].toString(),
            onChange: (val) {
              formMap['pressureDuration'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '熟豆放豆时间',
            prop: formMap['addBeanDate'],
            onChange: (val) {
              formMap['addBeanDate'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '备注',
            keyboardType: 'text',
            prop: formMap['remark'],
            onChange: (val) {
              formMap['remark'] = val;
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
