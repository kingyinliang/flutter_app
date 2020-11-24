import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';

class AcceReceivePage extends StatefulWidget {
  final arguments;
  AcceReceivePage({Key key, this.arguments}) : super(key: key);

  @override
  _AcceReceivePageState createState() => _AcceReceivePageState();
}

class _AcceReceivePageState extends State<AcceReceivePage> {
  bool isSplit = false;
  Map<String, dynamic> formMap = {
    'useMaterialName': '',
    'useUnit': '',
    'useAmount': '',
    'useBatch': '',
    'addDate': '',
    'useBoxNo': '',
    'remark': '',
    'splitFlag': 'Y',
  };
  List useBoxNo = [];

  _submitForm() async {
    if (formMap['useAmount'] == null || formMap['useAmount'] == '') {
      EasyLoading.showError('请填写领用数量');
      return;
    }
    if (formMap['useBatch'] == null || formMap['useBatch'] == '') {
      EasyLoading.showError('请填写领用批次');
      return;
    }
    if (formMap['useBatch'].length != 10) {
      EasyLoading.showError('领用批次10位');
      return;
    }
    if (formMap['addDate'] == null || formMap['addDate'] == '') {
      EasyLoading.showError('请填写添加时间');
      return;
    }
    formMap['useType'] = '1';
    if (formMap['id'] != null) {
      try {
        await Sterilize.acceAddAcceReceiveUpdateApi(formMap);
        if (isSplit) {
          formMap['useAmount'] = '';
          formMap['useBatch'] = '';
          formMap['addDate'] = '';
          formMap['useBoxNo'] = '';
          formMap['remark'] = '';
          setState(() {});
        } else {
          Navigator.pop(context, true);
        }
      } catch (e) {}
    } else {
      try {
        await Sterilize.acceAddAcceReceiveAddApi(formMap);
        if (isSplit) {
          formMap['useAmount'] = '';
          formMap['useBatch'] = '';
          formMap['addDate'] = '';
          formMap['useBoxNo'] = '';
          formMap['remark'] = '';
          setState(() {});
        } else {
          Navigator.pop(context, true);
        }
      } catch (e) {}
    }
  }

  _getUseBoxNo() async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery({
        'deptId': workShop,
        'holderType': ['023']
      });
      useBoxNo = res['data'];
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
          FormTextWidget(
            label: '领用物料',
            prop: formMap['useMaterialName'].toString(),
          ),
          FormTextWidget(
            label: '单位',
            prop: formMap['useUnit'].toString(),
          ),
          InputWidget(
            label: '领用数量',
            keyboardType: 'number',
            prop: formMap['useAmount'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['useAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '领用批次',
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            prop: formMap['useBatch'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['useBatch'] = val;
              setState(() {});
            },
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
            label: '称取盒编号',
            prop: formMap['useBoxNo'].toString(),
            options: useBoxNo,
            optionsLabel: 'holderName',
            optionsval: 'holderNo',
            onChange: (val) {
              formMap['useBoxNo'] = val['holderNo'];
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
            },
          ),
          formMap['id'] == null
              ? SwitchWidget(
                  label: '是否拆分',
                  prop: isSplit,
                  onChange: (val) {
                    isSplit = val;
                    setState(() {});
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    formMap['useMaterialName'] = widget.arguments['useMaterialName'];
    formMap['useMaterialType'] = widget.arguments['useMaterialType'];
    formMap['useMaterialCode'] = widget.arguments['useMaterialCode'];
    formMap['useUnit'] = widget.arguments['useUnit'];
    formMap['potOrderNo'] = widget.arguments['potOrderNo'];
    formMap['potOrderId'] = widget.arguments['potOrderId'];
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getUseBoxNo();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(
        titleData: formMap['id'] == null ? '辅料领用新增' : '辅料领用修改',
        refresh: true,
      ),
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
