import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';

class ExceptionAdd extends StatefulWidget {
  final arguments;
  ExceptionAdd({Key key, this.arguments}) : super(key: key);

  @override
  _ExceptionAddState createState() => _ExceptionAddState();
}

class _ExceptionAddState extends State<ExceptionAdd> {
  Map formMap = {
    'classes': '',
    'exceptionSituation': '',
    'startDate': '',
    'endDate': '',
    'duration': '0',
    'durationString': '0分钟',
    'durationUnit': 'MIN',
    'exceptionReason': '',
    'exceptionInfo': '',
    'remark': '',
    'exceptionStage': ''
  };
  List classList = [];
  List abnormalList = [];
  List reasonResList = [];

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
      if (formMap['startDate'] == null) {
        formMap['startDate'] = '';
      }
      if (formMap['endDate'] == null) {
        formMap['endDate'] = '';
      }
      formMap['durationString'] = '${formMap['duration']}分钟';
      if (formMap['exceptionSituation'] != null &&
          formMap['exceptionSituation'] != '') {
        this._getAbnormalReason(formMap['exceptionSituation']);
      }
    }
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getClassList();
        _getAbnormalList();
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
            label: '班次',
            prop: formMap['classes'].toString(),
            requiredFlg: true,
            options: classList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['classes'] = val['dictCode'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '异常情况',
            prop: formMap['exceptionSituation'].toString(),
            requiredFlg: true,
            options: abnormalList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['exceptionSituation'] = val['dictCode'];
              this._getAbnormalReason(val['dictCode']);
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '开始时间',
            prop: formMap['startDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['startDate'] = val;
              this._getDuration();
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '结束时间',
            prop: formMap['endDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['endDate'] = val;
              this._getDuration();
              setState(() {});
            },
          ),
          InputWidget(
            label: '时长',
            prop: formMap['durationString'].toString(),
            enabled: false,
            onChange: (val) {
              formMap['durationString'] = val;
              setState(() {});
            },
          ),
          SelectWidget(
            label: '异常原因',
            prop: formMap['exceptionReason'].toString(),
            requiredFlg: true,
            options: this.reasonResList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              formMap['exceptionReason'] = val['dictCode'];
              setState(() {});
            },
          ),
          InputWidget(
              label: '异常描述',
              prop: formMap['exceptionInfo'].toString(),
              onChange: (val) {
                formMap['exceptionInfo'] = val;
                setState(() {});
              }),
          InputWidget(
              label: '备注',
              keyboardType: 'text',
              prop: formMap['remark'].toString(),
              onChange: (val) {
                formMap['remark'] = val;
                setState(() {});
              })
        ],
      ),
    );
  }

  // 班次下拉
  _getClassList() async {
    try {
      var res = await Common.classListQuery({'dictType': 'CRAFT_PHASE'});
      this.classList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  // 异常情况
  _getAbnormalList() async {
    try {
      var abnormalRes =
          await Common.dictDropDownQuery({'dictType': 'ABNORMAL_HALT'});
      this.abnormalList = abnormalRes['data'];
      setState(() {});
    } catch (e) {}
  }

  // 异常原因
  _getAbnormalReason(val) async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      if (val == 'FAULT' || val == 'SHUTDOWN') {
        var reasonRes = await Common.deviceListQuery({'deptId': workShop});
        reasonRes['data'].forEach((item) => {
              this.reasonResList.add({
                'dictValue': item['deviceName'],
                'dictCode': item['deviceNo']
              })
            });
      } else if (val == 'POOR_PROCESS' || val == 'WAIT') {
        var reasonRes =
            await Common.dictDropDownQuery({'dictType': 'POOR_PROCESS_WAIT'});
        this.reasonResList = reasonRes['data'];
      } else if (val == 'ENERGY') {
        var reasonRes = await Common.dictDropDownQuery({'dictType': 'ENERGY'});
        this.reasonResList = reasonRes['data'];
      }
      setState(() {});
    } catch (e) {}
  }

  // 获取时长
  _getDuration() {
    if (formMap['startDate'] != '' && formMap['endDate'] != '') {
      int nowyear = int.parse(formMap['startDate'].split(" ")[0].split('-')[0]);
      int nowmonth =
          int.parse(formMap['startDate'].split(" ")[0].split('-')[1]);
      int nowday = int.parse(formMap['startDate'].split(" ")[0].split('-')[2]);
      int nowhour = int.parse(formMap['startDate'].split(" ")[1].split(':')[0]);
      int nowmin = int.parse(formMap['startDate'].split(" ")[1].split(':')[1]);

      int oldyear = int.parse(formMap['endDate'].split(" ")[0].split('-')[0]);
      int oldmonth = int.parse(formMap['endDate'].split(" ")[0].split('-')[1]);
      int oldday = int.parse(formMap['endDate'].split(" ")[0].split('-')[2]);
      int oldhour = int.parse(formMap['endDate'].split(" ")[1].split(':')[0]);
      int oldmin = int.parse(formMap['endDate'].split(" ")[1].split(':')[1]);

      var now = new DateTime(nowyear, nowmonth, nowday, nowhour, nowmin);
      var old = new DateTime(oldyear, oldmonth, oldday, oldhour, oldmin);
      var difference = old.difference(now);

      formMap['duration'] = difference.inMinutes; // 时间差
      formMap['durationString'] = '${difference.inMinutes}分钟'; // 时间差

    }
  }

  _submitForm() async {
    if (formMap['classes'] == null || formMap['classes'] == '') {
      EasyLoading.showError('请选择班次');
      return;
    }
    if (formMap['exceptionSituation'] == null ||
        formMap['exceptionSituation'] == '') {
      EasyLoading.showError('请选择异常情况');
      return;
    }
    if (formMap['startDate'] == null || formMap['startDate'] == '') {
      EasyLoading.showError('请选择开始时间');
      return;
    }
    if (formMap['endDate'] == null || formMap['endDate'] == '') {
      EasyLoading.showError('请选择结束时间');
      return;
    }

    if (formMap['exceptionSituation'] != 'AB_OTHERS' &&
        formMap['exceptionReason'] == '') {
      EasyLoading.showError('请选择异常原因');
      return;
    }

    formMap['exceptionStage'] = widget.arguments['typeCode'];
    formMap['changed'] =
        new DateTime.now().toString().split('.')[0].replaceAll('-', '-');
    if (formMap['id'] != null) {
      try {
        await Sterilize.sterilizeExceptionDetailUpdateApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        formMap['orderId'] = widget.arguments['potDetail']['orderId'];
        formMap['orderNo'] = widget.arguments['potDetail']['orderNo'];
        formMap['potOrderNo'] = widget.arguments['potDetail']['potNo'];
        formMap['potOrderId'] = widget.arguments['potDetail']['potOrderId'];
        await Sterilize.sterilizeExceptionDetailInsertApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(
          titleData: formMap['id'] == null ? '异常记录新增' : '异常记录修改'),
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
