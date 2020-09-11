import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';

class MaterialAddPage extends StatefulWidget {
  final arguments;
  MaterialAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _MaterialAddPageState createState() => _MaterialAddPageState();
}

class _MaterialAddPageState extends State<MaterialAddPage> {
  Map<String, dynamic> formMap = {
    'potOrderNo': '',
    'potOrderId': '',
    'useMaterialCode': '',
    'useMaterialName': '',
    'useUnit': '',
    'useAmount': '',
    'useBatch': '',
    'addDate': '',
    'remark': '',
    'splitFlag': 'N',
  };
  List useMaterial = [];
  List useUnit = [];

  _getUseMaterial() async {
    try {
      var res = await Common.dictDropDownQuery({
        'dictType': 'STE_SUP_MATERIAL',
      });
      useMaterial = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _getUseUnit() async {
    try {
      var res = await Common.dictDropDownQuery({
        'dictType': 'COMMON_UNIT',
      });
      useUnit = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _submitForm() async {
    if (formMap['useAmount'] == null || formMap['useAmount'] == '') {
      EasyLoading.showError('请填写领用数量');
      return;
    }
    if (formMap['useBatch'] == null || formMap['useBatch'] == '') {
      EasyLoading.showError('请填写领用批次');
      return;
    }
    if (formMap['addDate'] == null || formMap['addDate'] == '') {
      EasyLoading.showError('请填写添加时间');
      return;
    }
    formMap['useType'] = '2';
    if (formMap['id'] != null) {
      try {
        await Sterilize.acceAddMaterialUpdateApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await Sterilize.acceAddMaterialAddApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    formMap['potOrderNo'] = widget.arguments['potOrderNo'];
    formMap['potOrderId'] = widget.arguments['potOrderId'];
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getUseMaterial();
        _getUseUnit();
      }),
    );
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SelectWidget(
            label: '领用物料',
            prop: formMap['useMaterialCode'].toString(),
            options: useMaterial,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['useMaterialCode'] = val['dictCode'];
              formMap['useMaterialName'] = val['dictValue'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '单位',
            prop: formMap['useUnit'].toString(),
            options: useUnit,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['useUnit'] = val['dictCode'];
              setState(() {});
            },
          ),
          InputWidget(
              label: '领用数量',
              prop: formMap['useAmount'].toString(),
              requiredFlg: true,
              onChange: (val) {
                formMap['useAmount'] = val;
                setState(() {});
              }),
          InputWidget(
              label: '领用批次',
              prop: formMap['useBatch'].toString(),
              requiredFlg: true,
              onChange: (val) {
                formMap['useBatch'] = val;
                setState(() {});
              }),
          DataPickerWidget(
            label: '添加时间',
            prop: formMap['addDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['addDate'] = val;
              setState(() {});
            },
          ),
          InputWidget(
              label: '备注',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MdsAppBarWidget(titleData: formMap['id'] == null ? '增补料新增' : '增补料修改'),
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
