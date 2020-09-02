import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import '../../../components/raisedButton.dart';
import '../common/page_head.dart';
import '../../../components/slide_button.dart';
import '../common/item_card.dart';
import '../common/remove_btn.dart';

List potArr = [
  {
    'num1': '55',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  },
  {
    'num1': '892',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  },
  {
    'num1': '785',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  },
  {
    'num1': '892',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  }
];
List wrapList = [
  {'label': '', 'value': 'name'},
  {'label': '', 'value': 'name1'},
  {'label': '', 'value': 'name2'},
  {'label': '', 'value': 'name3'},
  {'label': '', 'value': 'name4'},
  {'label': '配置日期：', 'value': 'name5'},
  {'label': '添加时间', 'value': 'name6'},
  {'label': '剩余库存', 'value': 'name7'},
  {'label': '', 'value': 'name8'},
  {'label': '', 'value': 'name9'},
  {'label': '备注：', 'value': 'name10'},
];

class SemiReceivePage extends StatefulWidget {
  SemiReceivePage({Key key}) : super(key: key);

  @override
  _SemiReceivePageState createState() => _SemiReceivePageState();
}

class _SemiReceivePageState extends State<SemiReceivePage> {
  getListCard() {
    List listWidget = [];
    listWidget = potArr.asMap().keys.map((index) {
      var key = GlobalKey<SlideButtonState>();
      return SlideButton(
        key: key,
        singleButtonWidth: 70,
        child: ItemCard(
          carTitle: '煮料锅领用数量',
          cardMap: potArr[index],
          title: 'num1',
          subTitle: 'util',
          wrapList: wrapList,
        ),
        buttons: <Widget>[
          CardRemoveBtn(
            removeOnTab: () {
              potArr.removeAt(index);
              setState(() {});
            },
          ),
        ],
        onDown: () {},
      );
    }).toList();
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '半成品领用'),
      backgroundColor: Color(0xFFF5F5F5),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.fromLTRB(0, 0, 12, 10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sterilize/semiReceive/add');
                },
                child: Icon(Icons.add),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: MdsWidthButton(
                text: '提交',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          PageHead(
            title: '1#锅 第2锅',
            subTitle: '杀菌完黄豆酱',
            orderNo: '83300023456',
            potNo: '83300023456',
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
            child: Column(
              children: getListCard(),
            ),
          ),
        ],
      ),
    );
  }
}
