import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import '../../../components/raisedButton.dart';
import '../common/formItem.dart';

class PotAddPage extends StatefulWidget {
  PotAddPage({Key key}) : super(key: key);

  @override
  _PotAddPageState createState() => _PotAddPageState();
}

class _PotAddPageState extends State<PotAddPage> {
  String input = '1';
  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          FormItem(
              type: 'select', label: '煮料锅号', prop: input, requiredFlg: true),
          FormItem(
              type: 'select', label: '配置日期', prop: input, requiredFlg: true),
          FormItem(
              type: 'select', label: '煮料锅序', prop: input, requiredFlg: true),
          FormItem(
              type: 'input',
              label: '煮料锅单',
              prop: input,
              onChange: (val) {
                input = val;
                setState(() {});
              }),
          FormItem(
              type: 'input',
              label: '生产物料',
              prop: input,
              onChange: (val) {
                input = val;
                setState(() {});
              }),
          FormItem(
              type: 'input',
              label: '剩余锅数',
              prop: input,
              onChange: (val) {
                input = val;
                setState(() {});
              }),
          FormItem(
              type: 'input',
              label: '领用数量',
              prop: input,
              requiredFlg: true,
              onChange: (val) {
                input = val;
                setState(() {});
              }),
          FormItem(
              type: 'input',
              label: '剩余库存',
              prop: input,
              onChange: (val) {
                input = val;
                setState(() {});
              }),
          FormItem(
              type: 'input',
              label: '单位',
              prop: input,
              onChange: (val) {
                input = val;
                setState(() {});
              }),
          FormItem(
              type: 'select', label: '添加时间', prop: input, requiredFlg: true),
          FormItem(type: 'select', label: '转运罐号', prop: input),
          FormItem(
              type: 'input',
              label: '备注',
              prop: input,
              onChange: (val) {
                input = val;
                setState(() {});
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '煮料锅新增'),
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
