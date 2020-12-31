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

  _submitForm() async {
    // if (formMap['steamBallNo'] == null || formMap['steamBallNo'] == '') {
    //   errorToast(msg: '请选择蒸球号');
    //   return;
    // }
    // if (formMap['addSteamStart'] == null || formMap['addSteamStart'] == '') {
    //   errorToast(msg: '请选择加汽开始时间');
    //   return;
    // }
    // if (formMap['addSteamEnd'] == null || formMap['addSteamEnd'] == '') {
    //   errorToast(msg: '请选择加汽结束时间');
    //   return;
    // }
    // if (formMap['cookingDuration'] == null ||
    //     formMap['cookingDuration'] == '') {
    //   errorToast(msg: '请输入蒸煮时间');
    //   return;
    // }
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
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '加汽结束时间',
            prop: formMap['addSteamEnd'],
            requiredFlg: true,
            onChange: (val) {
              formMap['addSteamEnd'] = val;
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
          InputWidget(
            label: '蒸煮时间',
            suffix: 'min',
            keyboardType: 'number',
            requiredFlg: true,
            prop: formMap['cookingDuration'].toString(),
            onChange: (val) {
              formMap['cookingDuration'] = val;
              setState(() {});
            },
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
