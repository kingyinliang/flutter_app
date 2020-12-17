import 'package:dfmdsapp/utils/index.dart';

class SteamGrowEvaluateAddPage extends StatefulWidget {
  final arguments;
  SteamGrowEvaluateAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamGrowEvaluateAddPageState createState() =>
      _SteamGrowEvaluateAddPageState();
}

class _SteamGrowEvaluateAddPageState extends State<SteamGrowEvaluateAddPage> {
  Map<String, dynamic> formMap = {
    'exceptionInfo': '',
    'growInfo': '',
    'growInfoName': '',
    'kojiOrderNo': '',
    'kojiStage': '',
    'orderNo': '',
    'recordDate': '',
    'recordMans': '',
    'remark': ''
  };

  List kojiStageList = [];
  List growInfoList = [];

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    formMap['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getKojiStageList(); // 获取制曲阶段下拉
        _getGrowInfoList(); // 获取生长情况下拉
      }),
    );
    super.initState();
  }

  _getKojiStageList() async {
    try {
      var res = await Common.dictDropDownQuery(
          {'dictType': 'KOJI_GROWTH_STAGE'}); // 从数据字典里获制曲阶段
      kojiStageList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _getGrowInfoList() async {
    try {
      var res = await Common.dictDropDownQuery(
          {'dictType': 'COMMON_SITUATION'}); // 从数据字典里获取生长情况下拉
      growInfoList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _submitForm() async {
    if (formMap['kojiStage'] == null || formMap['kojiStage'] == '') {
      errorToast(msg: '请选择评价阶段');
      return;
    }
    if (formMap['recordDate'] == null || formMap['recordDate'] == '') {
      errorToast(msg: '请选择记录时间');
      return;
    }
    if (formMap['growInfo'] == null || formMap['growInfo'] == '') {
      errorToast(msg: '请选择生产情况');
      return;
    }
    if (formMap['growInfo'] != 'GOOD' && formMap['exceptionInfo'] == '') {
      errorToast(msg: '请填写异常描述');
      return;
    }
    if (formMap['recordMans'] == null || formMap['recordMans'] == '') {
      errorToast(msg: '请选择记录人');
      return;
    }
    formMap['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    if (formMap['id'] != null) {
      try {
        await KojiMaking.steamDiscEvaluateSave(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await KojiMaking.steamDiscEvaluateSave(formMap);
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
          SelectWidget(
            label: '评价阶段',
            prop: formMap['kojiStage'].toString(),
            requiredFlg: true,
            options: kojiStageList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['kojiStage'] = val['dictCode'];
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '记录时间',
            prop: formMap['recordDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['recordDate'] = val;
              setState(() {});
            },
          ),
          SelectWidget(
            label: '生长情况',
            prop: formMap['growInfo'].toString(),
            requiredFlg: true,
            options: growInfoList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['growInfo'] = val['dictCode'];
              formMap['growInfoName'] = val['dictValue'];
              setState(() {});
            },
          ),
          InputWidget(
            label: '异常描述',
            keyboardType: 'text',
            prop: formMap['exceptionInfo'],
            onChange: (val) {
              formMap['exceptionInfo'] = val;
              setState(() {});
            },
          ),
          OrgSelectUser(
            label: '记录人',
            prop: formMap['recordMans'].split(','),
            requiredFlg: true,
            onChange: (List val) {
              formMap['recordMans'] = val.join(',');
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
