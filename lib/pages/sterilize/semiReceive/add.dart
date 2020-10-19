import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';

class AddSemiReceivePage extends StatefulWidget {
  final arguments;
  AddSemiReceivePage({Key key, this.arguments}) : super(key: key);

  @override
  _AddSemiReceivePageState createState() => _AddSemiReceivePageState();
}

class _AddSemiReceivePageState extends State<AddSemiReceivePage> {
  Map<String, dynamic> formMap = {
    'consumeType': '1',
    'fermentPotNo': '',
    'fermentPotName': '',
    'materialCode': '',
    'consumeUnit': '',
    'consumeAmount': '',
    'consumeBatch': '',
    'fermentStorage': '',
    'tankNo': '',
    'tankName': '',
    'remark': '',
  };

  List potList = [];
  List materialList = [];
  List transferTank = [];
  List consumeType = [
    {
      'label': '是',
      'val': '1',
    },
    {
      'label': '否',
      'val': '0',
    }
  ];

  _submitForm() async {
    if (formMap['fermentPotNo'] == null || formMap['fermentPotNo'] == '') {
      EasyLoading.showError('请填写发酵罐号');
      return;
    }
    if (formMap['materialCode'] == null || formMap['materialCode'] == '') {
      EasyLoading.showError('请填写领用物料');
      return;
    }
    if (formMap['consumeAmount'] == null || formMap['consumeAmount'] == '') {
      EasyLoading.showError('请填写领用数量');
      return;
    }
    if (formMap['consumeBatch'] == null || formMap['consumeBatch'] == '') {
      EasyLoading.showError('请填写领用批次');
      return;
    }
    if (formMap['consumeBatch'].length != 10) {
      EasyLoading.showError('领用批次10位');
      return;
    }
    if (formMap['id'] != null) {
      try {
        await Sterilize.semiUpdateApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await Sterilize.semiAddApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  _getPotList() async {
    var factoryId = await SharedUtil.instance.getStorage('factoryId');
    try {
      var res = await Common.holderDropDownQuery(
          {'factory': factoryId, 'holderType': '001'});
      potList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _getMaterial() async {
    try {
      var res = await Common.orderBoom({
        'materialType': 'ZHAL',
        'orderNoList': [widget.arguments['orderNo']]
      });
      materialList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _getTransferTank() async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery(
          {'deptId': workShop, 'holderType': '022'});
      transferTank = res['data'];
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
            label: '发酵罐领用',
            prop: formMap['consumeType'].toString(),
            requiredFlg: true,
            options: consumeType,
            optionsLabel: 'label',
            optionsval: 'val',
            onChange: (val) {
              formMap['consumeType'] = val['val'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '发酵罐号',
            prop: formMap['fermentPotNo'].toString(),
            requiredFlg: true,
            options: potList,
            optionsLabel: 'holderName',
            optionsval: 'holderNo',
            onChange: (val) {
              formMap['fermentPotNo'] = val['holderNo'];
              formMap['fermentPotName'] = val['holderName'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '领用物料',
            prop: formMap['materialCode'].toString(),
            requiredFlg: true,
            options: materialList,
            optionsLabel: 'materialName',
            optionsval: 'matnr',
            onChange: (val) {
              formMap['materialCode'] = val['matnr'];
              formMap['consumeUnit'] = val['erfme'];
              formMap['materialName'] = val['materialName'];
              formMap['materialType'] = val['materialType'];
              setState(() {});
            },
          ),
          FormTextWidget(
            label: '单位',
            prop: formMap['consumeUnit'].toString(),
          ),
          InputWidget(
            label: '领用数量',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '领用批次',
            prop: formMap['consumeBatch'].toString(),
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            requiredFlg: true,
            onChange: (val) {
              formMap['consumeBatch'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '发酵罐库存',
            prop: formMap['fermentStorage'].toString(),
            onChange: (val) {
              formMap['fermentStorage'] = val;
              setState(() {});
            },
          ),
          SelectWidget(
            label: '转运罐号',
            prop: formMap['tankNo'].toString(),
            options: transferTank,
            optionsLabel: 'holderName',
            optionsval: 'holderNo',
            onChange: (val) {
              formMap['tankNo'] = val['holderNo'];
              formMap['tankName'] = val['holderName'];
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
    formMap['potOrderNo'] = widget.arguments['potOrderNo'];
    formMap['potOrderId'] = widget.arguments['potOrderId'];
    formMap['stePotNo'] = widget.arguments['stePotNo'];
    formMap['orderNo'] = widget.arguments['orderNo'];
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getPotList();
        _getMaterial();
        _getTransferTank();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(
          titleData: formMap['id'] == null ? '半成品领用新增' : '半成品领用修改'),
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
