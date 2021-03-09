import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:date_format/date_format.dart';

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

  bool isFirst = false;
  List typeList = [];
  List stageList = [];
  List craftTable = [
    {
      'controlType': '',
      'controlStage': '',
      'stageList': [],
      'recordDate': '',
      'temp': '',
      'remark': '',
    }
  ];
  Map craftInfo = {};

  _submitForm() async {
    // if (formMap['controlType'] == null || formMap['controlType'] == '') {
    //   EasyLoading.showError('请选择类型');
    //   return;
    // }
    // if (formMap['controlStage'] == null || formMap['controlStage'] == '') {
    //   EasyLoading.showError('请选择阶段');
    //   return;
    // }
    // if (formMap['recordDate'] == null || formMap['recordDate'] == '') {
    //   EasyLoading.showError('请选择记录时间');
    //   return;
    // }
    if (isFirst == true || craftTable[0]['id'] == null) {
      try {
        craftTable.forEach((element) {
          element['potOrderNo'] = widget.arguments['potOrderNo'];
          element['potOrderId'] = widget.arguments['potOrderId'];
        });
        await Sterilize.sterilizeCraftMaterialTimeInsertApi(craftTable);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        if (craftTable[0]['temp'] == '') {
          craftTable[0]['temp'] = 0;
        }
        craftTable[0]['potOrderNo'] = widget.arguments['potOrderNo'];
        await Sterilize.sterilizeCraftMaterialTimeUpdateApi(craftTable[0]);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  _dataChange(row, index) {
    if (craftTable[index + 1] != null &&
        craftTable[index + 1]['controlType'] == 'HEAT' &&
        craftTable[index + 1]['recordDate'] != '') {
      var val = craftTable[index + 1];
      var date = craftTable[index]['recordDate'];
      var finalTimes = DateTime.parse(date);
      String valueFormat = 'yyyy-mm-dd HH:nn';
      List<String> valueFormatArr = [];
      RegExp reg = new RegExp(r"(.)\1*");
      Iterable<Match> a = reg.allMatches(valueFormat);
      a.forEach((element) {
        String match = element.group(0);
        valueFormatArr.add(match);
      });
      if (val == 'HEAT_10MIN' && row['recordDate'] == '') {
        print('保温10分钟');
        var newTime = finalTimes.add(Duration(minutes: 10));
        row['recordDate'] = formatDate(newTime, valueFormatArr);
      } else if (val == 'HEAT_15MIN' && row['recordDate'] == '') {
        var newTime = finalTimes.add(Duration(minutes: 15));
        row['recordDate'] = formatDate(newTime, valueFormatArr);
      } else if (val == 'HEAT_20MIN' && row['recordDate'] == '') {
        var newTime = finalTimes.add(Duration(minutes: 20));
        row['recordDate'] = formatDate(newTime, valueFormatArr);
      } else if (val == 'HEAT_30MIN' && row['recordDate'] == '') {
        var newTime = finalTimes.add(Duration(minutes: 30));
        row['recordDate'] = formatDate(newTime, valueFormatArr);
      } else if (val == 'HEAT_35MIN' && row['recordDate'] == '') {
        var newTime = finalTimes.add(Duration(minutes: 35));
        row['recordDate'] = formatDate(newTime, valueFormatArr);
      }
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
  _getStageList(row, val) async {
    try {
      var res = await Common.dictDropDownQuery({'dictType': val});
      row['stageList'] = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _changeStage(formMap) {
    var val = formMap['controlStage'];
    var row = formMap;
    if (row['controlType'] == 'HEAT') {
      // 保温
      _superLongNauseaJudgment1(val, row);
    } else if (row['controlType'] == 'DISCHARGE' ||
        row['controlType'] == 'COOL') {
      // 降温 & 出料
      _superLongNauseaJudgment2(val, row);
    }
  }

  _superLongNauseaJudgment1(val, row) {
    if (val == 'HEAT_START') {
      // 保温开始 默认 = 升温结束
      if (row['recordDate'] == '' &&
          craftInfo['riseEndDate'] != '' &&
          craftInfo['riseEndDate'] != null) {
        row['recordDate'] = craftInfo['riseEndDate'];
      }
    } else if (val != 'HEAT_TWO' && val != 'HEAT_END') {
      List sole = craftTable
          .where(
              (e) => e['controlStage'] == 'HEAT_TWO' && e['recordDate'] != '')
          .toList();
      if (sole.length == 0) {
        sole = craftTable
            .where((e) =>
                e['controlStage'] == 'HEAT_START' && e['recordDate'] != '')
            .toList();
      }
      if (sole.length != 0) {
        int number = sole.length - 1;
        var date = sole[number]['recordDate'];
        if (date != '') {
          var finalTimes = DateTime.parse(date);
          String valueFormat = 'yyyy-mm-dd HH:nn';
          List<String> valueFormatArr = [];
          RegExp reg = new RegExp(r"(.)\1*");
          Iterable<Match> a = reg.allMatches(valueFormat);
          a.forEach((element) {
            String match = element.group(0);
            valueFormatArr.add(match);
          });
          print(val);
          if (val == 'HEAT_10MIN' && row['recordDate'] == '') {
            print('保温10分钟');
            var newTime = finalTimes.add(Duration(minutes: 10));
            row['recordDate'] = formatDate(newTime, valueFormatArr);
          } else if (val == 'HEAT_15MIN' && row['recordDate'] == '') {
            var newTime = finalTimes.add(Duration(minutes: 15));
            row['recordDate'] = formatDate(newTime, valueFormatArr);
          } else if (val == 'HEAT_20MIN' && row['recordDate'] == '') {
            var newTime = finalTimes.add(Duration(minutes: 20));
            row['recordDate'] = formatDate(newTime, valueFormatArr);
          } else if (val == 'HEAT_30MIN' && row['recordDate'] == '') {
            var newTime = finalTimes.add(Duration(minutes: 30));
            row['recordDate'] = formatDate(newTime, valueFormatArr);
          } else if (val == 'HEAT_35MIN' && row['recordDate'] == '') {
            var newTime = finalTimes.add(Duration(minutes: 35));
            row['recordDate'] = formatDate(newTime, valueFormatArr);
          }
        }
      }
    }
    setState(() {});
  }

  _superLongNauseaJudgment2(val, row) {
    if (val == 'COOL_START' && row['recordDate'] == '') {
      // 降温开始 = 保温结束
      List sole = craftTable
          .where(
              (e) => e['controlStage'] == 'HEAT_END' && e['recordDate'] != '')
          .toList();
      if (sole.length != 0) {
        int number = sole.length - 1;
        var date = sole[number]['recordDate'];
        if (date != '') {
          row['recordDate'] = date;
        }
      }
    } else if (val == 'DISCHARGE_START') {
      // 出料开始 = 降温结束
      // 降温开始 = 保温结束
      List sole = craftTable
          .where(
              (e) => e['controlStage'] == 'COOL_END' && e['recordDate'] != '')
          .toList();
      if (sole.length != 0) {
        int number = sole.length - 1;
        var date = sole[number]['recordDate'];
        if (date != '') {
          row['recordDate'] = date;
        }
      }
    }
    setState(() {});
  }

  Widget formWidget(row, index) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SelectWidget(
            label: '类型',
            prop: row['controlType'].toString(),
            requiredFlg: true,
            options: typeList,
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              row['controlType'] = val['dictCode'];
              _getStageList(row, val['dictCode']);
              setState(() {});
            },
          ),
          SelectWidget(
            label: '阶段',
            prop: row['controlStage'].toString(),
            requiredFlg: true,
            options: row['stageList'],
            optionsLabel: 'dictValue',
            optionsval: 'dictCode',
            onChange: (val) {
              row['controlStage'] = val['dictCode'];
              _changeStage(row);
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '记录时间',
            prop: row['recordDate'].toString(),
            requiredFlg: true,
            onChange: (val) {
              row['recordDate'] = val;
              if (row['controlStage'] == 'HEAT_TWO') {
                _dataChange(row, index);
              }
              setState(() {});
            },
          ),
          InputWidget(
              label: '温度(℃)',
              keyboardType: 'number',
              prop: row['temp'].toString(),
              onChange: (val) {
                row['temp'] = val;
                setState(() {});
              }),
          InputWidget(
              label: '备注',
              keyboardType: 'text',
              prop: row['remark'].toString(),
              onChange: (val) {
                row['remark'] = val;
                setState(() {});
              }),
        ],
      ),
    );
  }

  List<Widget> _getListView() {
    List<Widget> listWidget = [];
    listWidget = craftTable.asMap().keys.map((index) {
      return formWidget(craftTable[index], index);
    }).toList();
    listWidget.add(SizedBox(height: 34));
    listWidget.add(MdsWidthButton(
      text: '确定',
      onPressed: _submitForm,
    ));
    listWidget.add(SizedBox(height: 34));
    return listWidget;
  }

  _init() async {
    try {
      var res = await Sterilize.sterilizeCraftMaterialListApi2(
          {"materialCode": widget.arguments['materialCode']});
      craftTable = [];
      await _getTypeList();
      List data = res['data'];
      data.forEach((item) {
        Map obj = {
          'controlType': item['type'],
          'controlStage': item['stage'],
          'stageList': [],
          'recordDate': '',
          'temp': '',
          'remark': '',
        };
        _getStageList(obj, obj['controlType']);
        craftTable.add(obj);
      });
      craftTable.forEach((item) {
        _changeStage(item);
      });
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        if (widget.arguments['data'] != null) {
          craftTable[0] = jsonDecode(jsonEncode(widget.arguments['data']));
          _getTypeList();
          if (craftTable[0]['controlType'] != '') {
            _getStageList(craftTable[0], craftTable[0]['controlType']);
          }
          if (craftTable[0]['recordDate'] == null) {
            craftTable[0]['recordDate'] = '';
          }
          if (craftTable[0]['temp'] == null) {
            craftTable[0]['temp'] = '';
          }
        } else if (widget.arguments['isFirst'] == true) {
          craftInfo = jsonDecode(jsonEncode(widget.arguments['craftInfo']));
          isFirst = true;
          _init();
        } else {
          craftInfo = jsonDecode(jsonEncode(widget.arguments['craftInfo']));
          _getTypeList();
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
        children: _getListView(),
      ),
    );
  }
}
