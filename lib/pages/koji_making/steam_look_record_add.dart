import 'package:dfmdsapp/utils/index.dart';

class SteamLookRecordAddPage extends StatefulWidget {
  final arguments;
  SteamLookRecordAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamLookRecordAddPageState createState() => _SteamLookRecordAddPageState();
}

class _SteamLookRecordAddPageState extends State<SteamLookRecordAddPage> {
  Map<String, dynamic> formMap = {
    'guardDate': '',
    'windTemp': '',
    'settingWindTemp': '',
    'roomTemp': '',
    'prodTemp': '',
    'settingProdTemp': '',
    'outUpTemp': '',
    'outMidTemp': '',
    'outDownTemp': '',
    'innerUpTemp': '',
    'innerMidTemp': '',
    'innerDownTemp': '',
    'windDoor': '',
    'forceDrain': '',
    'changeHot': '',
    'windSpeed': '',
    'testTempOne': '',
    'testTempTwo': '',
    'remark': '',
    'changed': '',
    'changer': '',
  };
  List typeList = [];
  List hotList = [];

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    Future.delayed(
      Duration.zero,
      () => setState(() {
        if (widget.arguments['onType'] == 'record') {
          _initState();
        }
      }),
    );
    super.initState();
  }

  _initState() async {
    // 强排下拉
    try {
      var res = await Common.dictDropDownQuery({'dictType': 'COMMON_OPEN_CLOSE'});
      typeList = res['data'];
      setState(() {});
    } catch (e) {}

    // 换热
    try {
      var res = await Common.dictDropDownQuery({'dictType': 'KOJI_HEAT_TRANSFER'});
      hotList = res['data'];
      setState(() {});
    } catch (e) {}

  }

  _submitForm() async {
    if (widget.arguments['onType'] == 'exception') {
      try {
        formMap['orderNo'] = widget.arguments['orderNo'];
        formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
        formMap['exceptionInfo'] = formMap['remark'];
        await KojiMaking.discLookExceptionSave(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      if (formMap['guardDate'] == null || formMap['guardDate'] == '') {
        EasyLoading.showError('请选择看曲时间');
        return;
      }
      if (formMap['windTemp'] == null || formMap['windTemp'] == '') {
        EasyLoading.showError('请填写实际风温');
        return;
      }
      if (formMap['roomTemp'] == null || formMap['roomTemp'] == '') {
        EasyLoading.showError('请填写下室温度');
        return;
      }
      if (formMap['prodTemp'] == null || formMap['prodTemp'] == '') {
        EasyLoading.showError('请填写品温');
        return;
      }
      if (formMap['outUpTemp'] == null || formMap['outUpTemp'] == '') {
        EasyLoading.showError('请填写外上温度');
        return;
      }
      if (formMap['outMidTemp'] == null || formMap['outMidTemp'] == '') {
        EasyLoading.showError('请填写外中温度');
        return;
      }
      if (formMap['outDownTemp'] == null || formMap['outDownTemp'] == '') {
        EasyLoading.showError('请填写外下温度');
        return;
      }
      if (formMap['windDoor'] == null || formMap['windDoor'] == '') {
        EasyLoading.showError('请填写风门开度');
        return;
      }
      if (formMap['forceDrain'] == null || formMap['forceDrain'] == '') {
        EasyLoading.showError('请选择强排设备');
        return;
      }
      if (formMap['changeHot'] == null || formMap['changeHot'] == '') {
        EasyLoading.showError('请选择换热设备');
        return;
      }
      if (formMap['windSpeed'] == null || formMap['windSpeed'] == '') {
        EasyLoading.showError('请填写风速');
        return;
      }
      if (formMap['testTempOne'] == null || formMap['testTempOne'] == '') {
        EasyLoading.showError('请填写测量温度1');
        return;
      }
      if (formMap['testTempTwo'] == null || formMap['testTempTwo'] == '') {
        EasyLoading.showError('请填写测量温度2');
        return;
      }
      if (formMap['id'] != null) {
        try {
          await KojiMaking.discLookSave(formMap);
          Navigator.pop(context, true);
        } catch (e) {}
      } else {
        try {
          formMap['orderNo'] = widget.arguments['orderNo'];
          formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
          await KojiMaking.discLookSave(formMap);
          Navigator.pop(context, true);
        } catch (e) {}
      }
    }
  }

  Widget formWidget() {
    if (widget.arguments['onType'] == 'exception') {
      return Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Text('异常情况',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 15),
                  textAlign: TextAlign.left
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SizedBox(height: 5),
            TextField(
              controller: TextEditingController.fromValue(
                  TextEditingValue(
                      text: formMap['remark'],
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(
                          TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: formMap['remark'].length
                          )
                      )
                  )
              ),
              maxLines: 4,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              onChanged: (val) {
                this.setState(() {
                  formMap['remark'] = val;
                });
              },
            ),
          ]
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
        child: Column(children: <Widget>[
          DataPickerWidget(
            label: '看曲时间',
            prop: formMap['guardDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['guardDate'] = val;
              setState(() {});
            },
          ),
          Container(
            height: 20,
            color: Color(0xFFF5F5F5),
            child: Text(
              '温度控制',
              style: TextStyle(color: Color(0xFF333333), fontSize: 17),
            ),
          ),
          InputWidget(
            label: '实际风温',
            keyboardType: 'number',
            suffix: '℃',
            prop: formMap['windTemp'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['windTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '设定风温',
            keyboardType: 'number',
            suffix: '℃',
            prop: formMap['settingWindTemp'].toString(),
            onChange: (val) {
              formMap['settingWindTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '下室温度',
            keyboardType: 'number',
            suffix: '℃',
            requiredFlg: true,
            prop: formMap['roomTemp'].toString(),
            onChange: (val) {
              formMap['roomTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '品温',
            keyboardType: 'number',
            suffix: '℃',
            requiredFlg: true,
            prop: formMap['prodTemp'].toString(),
            onChange: (val) {
              formMap['prodTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '设定品温',
            keyboardType: 'number',
            suffix: '℃',
            prop: formMap['settingProdTemp'].toString(),
            onChange: (val) {
              formMap['settingProdTemp'] = val;
              setState(() {});
            },
          ),
          Container(
            height: 20,
            color: Color(0xFFF5F5F5),
            child: Text(
              '探头温度',
              style: TextStyle(color: Color(0xFF333333), fontSize: 17),
            ),
          ),
          InputWidget(
            label: '外上温度',
            keyboardType: 'number',
            suffix: '℃',
            requiredFlg: true,
            prop: formMap['outUpTemp'].toString(),
            onChange: (val) {
              formMap['outUpTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '外中温度',
            keyboardType: 'number',
            suffix: '℃',
            requiredFlg: true,
            prop: formMap['outMidTemp'].toString(),
            onChange: (val) {
              formMap['outMidTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '外下温度',
            keyboardType: 'number',
            suffix: '℃',
            requiredFlg: true,
            prop: formMap['outDownTemp'].toString(),
            onChange: (val) {
              formMap['outDownTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '内上温度',
            keyboardType: 'number',
            suffix: '℃',
            prop: formMap['innerUpTemp'].toString(),
            onChange: (val) {
              formMap['innerUpTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '内中温度',
            keyboardType: 'number',
            suffix: '℃',
            prop: formMap['innerMidTemp'].toString(),
            onChange: (val) {
              formMap['innerMidTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '内下温度',
            keyboardType: 'number',
            suffix: '℃',
            prop: formMap['innerDownTemp'].toString(),
            onChange: (val) {
              formMap['innerDownTemp'] = val;
              setState(() {});
            },
          ),
          Container(
            height: 20,
            color: Color(0xFFF5F5F5),
            child: Text(
              '设备控制',
              style: TextStyle(color: Color(0xFF333333), fontSize: 17),
            ),
          ),
          InputWidget(
            label: '风门开度',
            keyboardType: 'number',
            requiredFlg: true,
            prop: formMap['windDoor'].toString(),
            onChange: (val) {
              formMap['windDoor'] = val;
              setState(() {});
            },
          ),
          SelectWidget(
            label: '强排设备',
            prop: formMap['forceDrain'].toString(),
            requiredFlg: true,
            options: typeList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['forceDrain'] = val['dictCode'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '换热设备',
            prop: formMap['changeHot'].toString(),
            requiredFlg: true,
            options: hotList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['changeHot'] = val['dictCode'];
              setState(() {});
            },
          ),
          InputWidget(
            label: '风速',
            keyboardType: 'number',
            suffix: 'm/s',
            requiredFlg: true,
            prop: formMap['windSpeed'].toString(),
            onChange: (val) {
              formMap['windSpeed'] = val;
              setState(() {});
            },
          ),
          Container(
            height: 20,
            color: Color(0xFFF5F5F5),
            child: Text(
              '测量温度',
              style: TextStyle(color: Color(0xFF333333), fontSize: 17),
            ),
          ),
          InputWidget(
            label: '测量温度1',
            keyboardType: 'number',
            suffix: '℃',
            requiredFlg: true,
            prop: formMap['testTempOne'].toString(),
            onChange: (val) {
              formMap['testTempOne'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '测量温度2',
            keyboardType: 'number',
            suffix: '℃',
            requiredFlg: true,
            prop: formMap['testTempTwo'].toString(),
            onChange: (val) {
              formMap['testTempTwo'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '备注',
            prop: formMap['remark'].toString(),
            onChange: (val) {
              formMap['remark'] = val;
              setState(() {});
            },
          ),
        ]),
      );
    }
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
