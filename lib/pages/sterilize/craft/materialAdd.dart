import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';

class CraftMaterialAdd extends StatefulWidget {
  final arguments;
  CraftMaterialAdd({Key key, this.arguments}) : super(key: key);

  @override
  _CraftMaterialAddState createState() => _CraftMaterialAddState();
}

class _CraftMaterialAddState extends State<CraftMaterialAdd> {
  Map<String, dynamic> formMap = {
    'feedStartDate': '',
    'feeEndDate': '',
    'riseStartDate': '',
    'riseEndDate': '',
    'keepZkFlag': '',
    'coolZkFlag': '',
    'remark': '',
  };

  List StageList = [
    {
      'label': '是',
      'val': 'Y',
    },
    {
      'label': '否',
      'val': 'N',
    }
  ];

  _submitForm() async {
    if (formMap['feedStartDate'] == null || formMap['feedStartDate'] == '') {
      EasyLoading.showError('请选择入料开始时间');
      return;
    }
    if (formMap['feeEndDate'] == null || formMap['feeEndDate'] == '') {
      EasyLoading.showError('请选择入料结束时间');
      return;
    }
    if (formMap['riseStartDate'] == null || formMap['riseStartDate'] == '') {
      EasyLoading.showError('请选择升温开始时间');
      return;
    }
    if (formMap['riseEndDate'] == null || formMap['riseEndDate'] == '') {
      EasyLoading.showError('请选择升温结束时间');
      return;
    }
    if (formMap['id'] != null) {
      try {
        await Sterilize.sterilizeCraftMaterialUpdateApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        formMap['potOrderNo'] = widget.arguments['potOrderNo'];
        formMap['potOrderId'] = widget.arguments['potOrderId'];
        await Sterilize.sterilizeCraftMaterialInsertApi(formMap);
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
          DataPickerWidget(
            label: '入料开始时间',
            prop: formMap['feedStartDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['feedStartDate'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '入料结束时间',
            prop: formMap['feeEndDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['feeEndDate'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '升温开始时间',
            prop: formMap['riseStartDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['riseStartDate'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '升温结束时间',
            prop: formMap['riseEndDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['riseEndDate'] = val;
              setState(() {});
            },
          ),
          SelectWidget(
            label: '保温阶段-ZK',
            prop: formMap['keepZkFlag'].toString(),
            requiredFlg: true,
            options: StageList,
            optionsLabel: 'label',
            optionsval: 'val',
            onChange: (val) {
              formMap['keepZkFlag'] = val['val'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '降温阶段-ZK',
            prop: formMap['coolZkFlag'].toString(),
            requiredFlg: true,
            options: StageList,
            optionsLabel: 'label',
            optionsval: 'val',
            onChange: (val) {
              formMap['coolZkFlag'] = val['val'];
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
      if (formMap['feedStartDate'] == null) {
        formMap['feedStartDate'] = '';
      }
      if (formMap['feeEndDate'] == null) {
        formMap['feeEndDate'] = '';
      }
      if (formMap['riseStartDate'] == null) {
        formMap['riseStartDate'] = '';
      }
      if (formMap['riseEndDate'] == null) {
        formMap['riseEndDate'] = '';
      }
    } else {
      formMap['keepZkFlag'] = 'N';
      formMap['coolZkFlag'] = 'N';
    }
    Future.delayed(
      Duration.zero,
          () => setState(() {
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