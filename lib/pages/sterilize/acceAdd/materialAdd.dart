import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import '../../../components/raisedButton.dart';
import '../common/formItem.dart';

class MaterialAddPage extends StatefulWidget {
  MaterialAddPage({Key key}) : super(key: key);

  @override
  _MaterialAddPageState createState() => _MaterialAddPageState();
}

class _MaterialAddPageState extends State<MaterialAddPage> {
  String input = '1';
  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          FormItem(type: 'select', label: '领用物料', prop: input),
          FormItem(type: 'text', label: '单位', prop: input),
          FormItem(
              type: 'input', label: '领用数量', prop: input, requiredFlg: true),
          FormItem(
              type: 'input', label: '领用批次', prop: input, requiredFlg: true),
          FormItem(
              type: 'select', label: '添加时间', prop: input, requiredFlg: true),
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
      appBar: MdsAppBarWidget(titleData: '增补料新增'),
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
