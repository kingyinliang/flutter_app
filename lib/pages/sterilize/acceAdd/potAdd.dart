import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';

class PotAddPage extends StatefulWidget {
  final arguments;
  PotAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _PotAddPageState createState() => _PotAddPageState();
}

class _PotAddPageState extends State<PotAddPage> {
  Map<String, dynamic> formMap = {
    'potOrderNo': '',
    'potOrderId': '',
    'potNo': '',
    'configDate': '',
    'cookingNum': '',
    'cookingOrderNo': '',
    'cookingMaterialCode': '',
    'remainderPot': '',
    'consumeAmount': '',
    'remainderAmount': '',
    'unit': '',
    'addDate': '',
    'transferTank': '',
    'remark': '',
  };
  List potList = [];
  List cookingNum = [];
  List transferTank = [];

  _submitForm() async {
    if (formMap['potNo'] == null || formMap['potNo'] == '') {
      EasyLoading.showError('请填写煮料锅号');
      return;
    }
    if (formMap['configDate'] == null || formMap['configDate'] == '') {
      EasyLoading.showError('请填写配置日期');
      return;
    }
    if (formMap['cookingNum'] == null || formMap['cookingNum'] == '') {
      EasyLoading.showError('请填写煮料锅序');
      return;
    }
    if (formMap['consumeAmount'] == null || formMap['consumeAmount'] == '') {
      EasyLoading.showError('请填写领用数量');
      return;
    }
    if (formMap['addDate'] == null || formMap['addDate'] == '') {
      EasyLoading.showError('请填写添加时间');
      return;
    }
    if (formMap['id'] != null) {
      try {
        await Sterilize.acceAddPotUpdateApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await Sterilize.acceAddPotAddApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  _getCookingNum() async {
    try {
      var res = await Sterilize.cookingNoApi({
        'configStartDate': formMap['configDate'],
        'potNo': formMap['potNo']
      });
      cookingNum = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _cookingNumChange(data) async {
    formMap['cookingId'] = data['id'];
    formMap['cookingOrderNo'] = data['cookingNo'];
    formMap['cookingMaterialCode'] = data['productMaterial'];
    formMap['cookingMaterialName'] = data['productMaterialName'];
    formMap['remainderPot'] = data['configPotCount'] - data['usePotCount'];
    formMap['remainderAmount'] = data['remainder'];
    try {
      var res = await Common.materialUnitQuery(
          {'materialCode': data['productMaterial']});
      formMap['unit'] = res['data'][0]['unit'];
      setState(() {});
    } catch (e) {}
  }

  _getPotList() async {
    var factoryId = await SharedUtil.instance.getStorage('factoryId');
    try {
      var res = await Common.holderDropDownQuery({
        'deptId': factoryId,
        'holderType': ['020']
      });
      potList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _getTransferTank() async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery({
        'deptId': workShop,
        'holderType': ['022']
      });
      transferTank = res['data'];
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
      Future.delayed(
        Duration.zero,
        () => setState(() {
          _getCookingNum();
        }),
      );
    }
    formMap['potOrderNo'] = widget.arguments['potOrderNo'];
    formMap['potOrderId'] = widget.arguments['potOrderId'];
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getPotList();
        _getTransferTank();
      }),
    );
    super.initState();
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SelectWidget(
            label: '煮料锅号',
            prop: formMap['potNo'],
            requiredFlg: true,
            options: potList,
            optionsLabel: 'holderName',
            optionsval: 'holderNo',
            onChange: (val) {
              formMap['potNo'] = val['holderNo'];
              _getCookingNum();
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '配置日期',
            prop: formMap['configDate'],
            valueFormat: 'yyyy-mm-dd',
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              _getCookingNum();
              setState(() {});
            },
          ),
          SelectWidget(
            label: '煮料锅序',
            prop: formMap['cookingNum'].toString(),
            requiredFlg: true,
            options: cookingNum,
            optionsLabel: 'potOrder',
            optionsLabel1: '第',
            optionsLabel2: '锅',
            optionsval: 'potOrder',
            onChange: (val) {
              formMap['cookingNum'] = val['potOrder'];
              _cookingNumChange(val);
              setState(() {});
            },
          ),
          FormTextWidget(
            label: '煮料锅单',
            prop: formMap['cookingOrderNo'].toString(),
          ),
          FormTextWidget(
            label: '生产物料',
            prop: formMap['cookingMaterialCode'].toString(),
          ),
          FormTextWidget(
            label: '剩余锅数',
            prop: formMap['remainderPot'].toString(),
          ),
          InputWidget(
              label: '领用数量',
              keyboardType: 'number',
              prop: formMap['consumeAmount'].toString(),
              requiredFlg: true,
              onChange: (val) {
                formMap['consumeAmount'] = val;
                setState(() {});
              }),
          FormTextWidget(
            label: '剩余库存',
            prop: formMap['remainderAmount'].toString(),
          ),
          FormTextWidget(
            label: '单位',
            prop: formMap['unit'].toString(),
          ),
          DataPickerWidget(
            label: '添加时间',
            prop: formMap['addDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['addDate'] = val;
              setState(() {});
            },
          ),
          SelectWidget(
            label: '转运罐号',
            prop: formMap['transferTank'].toString(),
            options: transferTank,
            optionsLabel: 'holderName',
            optionsval: 'holderNo',
            onChange: (val) {
              formMap['transferTank'] = val['holderNo'];
              setState(() {});
            },
          ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MdsAppBarWidget(titleData: formMap['id'] == null ? '煮料锅新增' : '煮料锅修改'),
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
