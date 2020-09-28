import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';

class CraftTimeAdd extends StatefulWidget {
  final arguments;
  CraftTimeAdd({Key key, this.arguments}) : super(key: key);

  @override
  _CraftTimeAddState createState() => _CraftTimeAddState();
}

class _CraftTimeAddState extends State<CraftTimeAdd> {
  Map<String, dynamic> formMap = {
    'controlType': '',
    'controlStage': '',
    'recordDate': '',
    'temp': '',
    'remark': '',
  };

  List typeList = [];
  List stageList = [];

  _submitForm() async {
    if (formMap['controlType'] == null || formMap['controlType'] == '') {
      EasyLoading.showError('请选择类型');
      return;
    }
    if (formMap['controlStage'] == null || formMap['controlStage'] == '') {
      EasyLoading.showError('请选择阶段');
      return;
    }
    if (formMap['recordDate'] == null || formMap['recordDate'] == '') {
      EasyLoading.showError('请选择记录时间');
      return;
    }
    if (formMap['id'] != null) {
      try {
        await Sterilize.sterilizeCraftMaterialTimeUpdateApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        formMap['potOrderNo'] = widget.arguments['potOrderNo'];
        formMap['potOrderId'] = widget.arguments['potOrderId'];
        await Sterilize.sterilizeCraftMaterialTimeInsertApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  // 类型下拉
  _getTypeList() async {
    try {
      var res = await Common.dictDropDownQuery({'dictType': 'CRAFT_PHASE'});
      typeList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  // 阶段下拉
  _getStageList(val) async {
    try {
      var res = await Common.dictDropDownQuery({'dictType': val});
      stageList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SelectWidget(
            label: '类型',
            prop: formMap['controlType'].toString(),
            requiredFlg: true,
            options: typeList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['controlType'] = val['dictCode'];
              _getStageList(val['dictCode']);
              setState(() {});
            },
          ),
          SelectWidget(
            label: '阶段',
            prop: formMap['controlStage'].toString(),
            requiredFlg: true,
            options: stageList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['controlStage'] = val['dictCode'];
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '记录时间',
            prop: formMap['recordDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['recordDate'] = val;
              setState(() {});
            },
          ),
          InputWidget(
              label: '温度(℃)',
              prop: formMap['temp'].toString(),
              onChange: (val) {
                formMap['temp'] = val;
                setState(() {});
              }),
          InputWidget(
              label: '备注',
              keyboardType: 'text',
              prop: formMap['remark'].toString(),
              onChange: (val) {
                formMap['remark'] = val;
                setState(() {});
              }),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getTypeList();
        if (formMap['controlType'] != '') {
          _getStageList(formMap['controlType']);
        }
        if (formMap['recordDate'] == null) {
          formMap['recordDate'] = '';
        }
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(
          titleData: formMap['id'] == null ? '工艺控制新增' : '工艺控制修改'),
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
