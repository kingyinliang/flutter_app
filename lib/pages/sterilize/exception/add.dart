import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import '../../../components/raisedButton.dart';
import '../../../components/form.dart';

class ExceptionAdd extends StatefulWidget {
  ExceptionAdd({Key key}) : super(key: key);

  @override
  _ExceptionAddState createState() => _ExceptionAddState();
}

class _ExceptionAddState extends State<ExceptionAdd> {
  String input = '1';
  String input2 = '2020-08-01 09:21';
  List potList = [
    {'label': '我是1', 'val': '1'},
    {'label': '我是2', 'val': '2'},
    {'label': '我是3', 'val': '3'}
  ];
  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SelectWidget(
            label: '班次',
            prop: input,
            requiredFlg: true,
            options: potList,
            optionsLabel: 'label',
            optionsval: 'val',
            onChange: (val) {
              input = val['label'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '异常情况',
            prop: input,
            requiredFlg: true,
            options: potList,
            optionsLabel: 'label',
            optionsval: 'val',
            onChange: (val) {
              input = val['label'];
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '开始时间',
            prop: input2,
            requiredFlg: true,
            onChange: (val) {
              input2 = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '结束时间',
            prop: input2,
            requiredFlg: true,
            onChange: (val) {
              input2 = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '时长',
            prop: input,
            onChange: (val) {
              input = val;
              setState(() {});
            }
           ),
          SelectWidget(
            label: '异常原因',
            prop: input,
            requiredFlg: true,
            options: potList,
            optionsLabel: 'label',
            optionsval: 'val',
            onChange: (val) {
              input = val['label'];
              setState(() {});
            },
          ),
          InputWidget(
              label: '异常描述',
              prop: input,
              onChange: (val) {
                input = val;
                setState(() {});
              }
          ),
          InputWidget(
            label: '备注',
            prop: input,
            onChange: (val) {
              input = val;
              setState(() {});
            }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '新增'),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          formWidget(),
          SizedBox(height: 34),
          MdsWidthButton(
            text: '确定',
            onPressed: () {
              input = '111';
              setState(() {});
            },
          ),
          SizedBox(height: 34),
        ],
      ),
    );
  }
}
